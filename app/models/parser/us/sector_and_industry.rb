module Parser::Us
  class SectorAndIndustry

    class << self
      def get(symbol)
        industry_parser = new(symbol)
        industry_parser.fetch
      end
    end

    def initialize(symbol)
      @symbol = symbol
    end

    def fetch
      begin
        @html = Formatter::Url.build("https://finance.yahoo.com/q/in?s=#{@symbol}+Industry")
        return sector_id, industry_id
      rescue => e
        Rails.logger.info("Parser::Us::SectorAndIndustry: #{e.message}")
        return default_sector_id, default_industry_id
      end
    end

  private
    def sector_name
      @html.css('table#yfncsumtab > tr[2] > td > table[2] > tr > td > table > tr[1] > td').text
    end

    def industry_name
      @html.css('table#yfncsumtab > tr[2] > td > table[2] > tr > td > table > tr[2] > td').text
    end

    def sector_id
      sector_name.blank? ? default_sector_id : sector_list["#{sector_name}"]
    end

    def industry_id
      UsIndustry.select(:id, :name).find_by(name: industry_name).try(:id) || default_industry_id
    end

    def sector_list
      I18n.t('us_industries.en').to_hash.invert
    end

    def default_sector_id
      1
    end

    def default_industry_id
      1
    end
  end
end
