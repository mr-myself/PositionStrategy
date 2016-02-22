module Parser::Jpn
  class Detail

    class << self
      def get(number)
        detail = new(number)
        {}.tap do |t|
          t[:market_value] = detail.market_value
          t[:base_info] = detail.base_info
        end
      end
    end

    def initialize(number)
      @number = number
    end

    def market_value
      build_market_value.each do |element|
        if element.css('dt').text =~ /時価総額/
          return element.css('.tseDtl > dd > strong').text.delete(',').delete('百万円').to_i
        end
      end
    end

    def base_info
      info = {}
      industry_list = PSConfig.industries.jpn.to_hash.invert
      build_base_info.each do |element|
        target = element.css('td')
        if target.first.text =~ /業種分類/
          industry = target[1].text
          info[:industry] = industry_list["#{industry}"].to_s.to_i
        end
        if target.first.text =~ /決算/
          info[:settling_day] = target[1].text
        end
        if target.first.text =~ /従業員数/
          info[:employee] = target[1].text.delete(',').delete('人').to_i
        end
        if target.first.text =~ /平均年齢/
          info[:age] = target[1].text.delete('歳').to_i
        end
        if target.text =~ /(.+?)年収(.+)$/
          info[:annual_income] = $2.delete(',').delete('千円').to_i
        end
      end
      info
    end

  private
    def build_market_value
      Formatter::Url.build("#{PSConfig.url.company.detail}#{@number}").css('.lineFi')
    end

    def build_base_info
      Formatter::Url.build("#{PSConfig.url.company.fundamental}/#{@number}").css('tr.yjMt')
    end
  end
end
