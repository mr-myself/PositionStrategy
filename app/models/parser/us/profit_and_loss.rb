module Parser::Us
  class ProfitAndLoss

    class << self
      def get(symbol)
        achievement = self.new(symbol)
        achievement.fetch_html
        achievement.parse
        achievement.achievement
      end
    end

    attr_accessor :achievement

    def initialize(symbol)
      @symbol = symbol
      @achievement = {}
    end

    def fetch_html
      @pl_html = Formatter::Url.build("https://finance.yahoo.com/q/is?s=#{@symbol}+Income+Statement&annual")
    end

    def parse
      destroy and return false unless parseable?

      @pl_html.css('table.yfnc_tabledata1 > tr > td > table > tr').each do |html|
        @achievement[:publish_day] ||= build_period(html)
        @achievement[:sale] ||= build_sale(html)
        @achievement[:operating_profit] ||= build_operating_profit(html)
        @achievement[:operating_profit_margin] ||= format_for_infinity(build_operating_profit_margin(html))
        @achievement[:net_income] ||= build_net_income(html)
      end
    end

  private
    def parseable?
      @pl_html and @pl_html.css('table.yfnc_tabledata1').present?
    end

    def build_period(html)
      return false unless html.css('td').first.text.include?("Period")
      # データが一期分の企業は採るべき指標が足りてない場合が多いため、削除
      destroy and return false if html.css('th')[1].blank?

      if html.css('th')[2].blank?
        {
          first:  html.css('th')[0].text,
          second: html.css('th')[1].text
        }
      else
        {
          first:  html.css('th')[0].text,
          second: html.css('th')[1].text,
          third:  html.css('th')[2].text
        }
      end
    end

    def build_sale(html)
      Parser::Us::FormatAchievement.format(html) if html.css('td').text.include?("Total Revenue")
    end

    def build_operating_profit(html)
      Parser::Us::FormatAchievement.format(html) if html.css('td').text.include?("Operating Income or Loss")
    end

    def build_operating_profit_margin(html)
      return nil unless (@achievement[:operating_profit] and @achievement[:operating_profit].count == 3)

      {
        first: @achievement[:operating_profit][:first].to_f / @achievement[:sale][:first].to_f * 100,
        second: @achievement[:operating_profit][:second].to_f / @achievement[:sale][:second].to_f * 100,
        third: @achievement[:operating_profit][:third].to_f / @achievement[:sale][:third].to_f * 100,
      }
    end

    def format_for_infinity(hash_data)
      return nil unless hash_data

      hash_data.tap do |h|
        [:first, :second, :third].each do |order|
          h[order] = 0 if h[order].to_s.match(/Infinity/) or h[order].to_s.match(/NaN/)
        end
      end
    end

    def build_net_income(html)
      Parser::Us::FormatAchievement.format(html) if html.css('td').text.gsub(/[\r\n]/,"").match(/Net\sIncome\s\s/)
    end

    def destroy
      ActiveRecord::Base.transaction do
        UsCompany.delete_all(symbol: @symbol)
        UsCompetitor.delete_all(my_symbol: @symbol)
        UsCompetitor.delete_all(other_symbol: @symbol)
      end
    end
  end
end
