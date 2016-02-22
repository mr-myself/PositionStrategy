module Parser::Us
  class BalanceSheet

    class << self
      def get(symbol, pl)
        return false unless pl[:publish_day]

        achievement = new(symbol, pl)
        achievement.fetch_html
        achievement.parse
        achievement.achievement
      end
    end

    attr_accessor :achievement

    def initialize(symbol, pl)
      @symbol = symbol
      @pl = pl
      @achievement = {}
    end

    def fetch_html
      @bs_html = Formatter::Url.build("https://finance.yahoo.com/q/bs?s=#{@symbol}+Balance+Sheet&annual")
    end

    def parse
      return false unless parseable?

      @bs_html.css('table.yfnc_tabledata1 > tr > td > table > tr').each do |html|
        @achievement[:roa] ||= format_for_infinity(build_roa(html))
        @achievement[:roe] ||= format_for_infinity(build_roe(html))
      end
    end

  private
    def parseable?
      @bs_html || @bs_html.css('table.yfnc_tabledata1').present?
    end

    def format_for_infinity(hash_data)
      return nil unless hash_data

      hash_data.tap do |h|
        [:first, :second, :third].each do |order|
          h[order] = 0 if h[order].to_s.match(/Infinity/) or h[order].to_s.match(/NaN/)
        end
      end
    end

    def build_roa(html)
      return false unless html.css('td').text.include?("Total Assets")
      total_assets = FormatAchievement.format(html)
      {
        first:  @pl[:operating_profit][:first].to_f / total_assets[:first].to_f * 100,
        second: @pl[:operating_profit][:second].to_f / total_assets[:second].to_f * 100,
        third:  @pl[:operating_profit][:third].to_f / total_assets[:third].to_f * 100,
      }
    end

    def build_roe(html)
      return false unless html.css('td').text.include?("Total Stockholder Equity")
      total_equity = FormatAchievement.format(html)
      {
        first:  @pl[:net_income][:first].to_f / total_equity[:first].to_f * 100,
        second: @pl[:net_income][:second].to_f / total_equity[:second].to_f * 100,
        third:  @pl[:net_income][:third].to_f / total_equity[:third].to_f * 100
      }
    end

    def destroy(symbol)
      ActiveRecord::Base.transaction do
        UsCompany.delete_all(symbol: symbol)
        UsCompetitor.delete_all(my_symbol: symbol)
        UsCompetitor.delete_all(other_symbol: symbol)
      end
    end
  end
end
