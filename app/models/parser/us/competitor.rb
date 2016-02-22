module Parser::Us
  class Competitor

    class << self
      def get(symbol)
        competitor = new(symbol)
        competitor.parse
        competitor.symbols
      end
    end

    attr_accessor :symbols

    def initialize(symbol)
      @my_symbol = symbol
      @symbols = []
    end

    def parse
      target_element = extract_target_element(fetch_html)
      return unless target_element

      target_element.css('a').try(:each) do |name|
        @symbols << name.text unless name.text[/#{@my_symbol}/] or name.text[/Industry/]
      end
    end

  private
    def fetch_html
      Formatter::Url.build("https://finance.yahoo.com/q/co?s=#{@my_symbol}+Competitors")
    end

    def extract_target_element(html)
      if extract_condition(html)
        html.css('table#yfncsumtab > tr')[1].css('td > table')[2]
      else
        false
      end
    end

    def extract_condition(html)
      html and
      html.css('table#yfncsumtab > tr') and
      html.css('table#yfncsumtab > tr').count >= 1 and
      html.css('table#yfncsumtab > tr')[1] and
      html.css('table#yfncsumtab > tr')[1].css('td > table') and
      html.css('table#yfncsumtab > tr')[1].css('td > table').count >= 2
    end
  end
end
