module CompetitorRepository

  class Us
    class << self
      def lookup(symbol)
        competitor = new(symbol)
        competitor_symbols = competitor.lookup_competitor_symbols
        competitor.lookup_companies(competitor_symbols)
      end
    end

    def initialize(symbol)
      @symbol = symbol
    end

    def lookup_competitor_symbols
      UsCompetitor.lookup(@symbol).pluck(:other_symbol)
    end

    def lookup_companies(symbols)
      UsCompany.where("symbol IN (?)", symbols)
    end
  end
end
