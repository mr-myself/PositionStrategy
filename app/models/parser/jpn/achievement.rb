module Parser::Jpn
  class Achievement

    def self.get(number)
      begin
        achievement = {}
        html = Formatter::Url.build("#{PSConfig.url.company.achievement}/#{number}")
        html.css('table.yjMt > tr').each do |element|
          target = element.css('td')
          if target.first.text =~ /^決算期/
            achievement[:publish_day] = {
              first: target[1].text,
              second: target[2].text,
              third: target[3].text,
            }
            achievement[:publish_year] = {
              first: target[1].text[0, 4],
              second: target[2].text[0, 4],
              third: target[3].text[0, 4],
            }
          end
          if target.first.text =~ /^売上高/
            achievement[:sale] = {
              first: target[1].text.delete(',').delete('百万円').to_i,
              second: target[2].text.delete(',').delete('百万円').to_i,
              third: target[3].text.delete(',').delete('百万円').to_i,
            }
          end
          if target.first.text =~ /^営業利益/
            achievement[:operating_profit] = {
              first: target[1].text.delete(',').delete('百万円').to_i,
              second: target[2].text.delete(',').delete('百万円').to_i,
              third: target[3].text.delete(',').delete('百万円').to_i,
            }
          end
          if target.first.text =~ /^経常利益/
            achievement[:ordinary_profit] = {
              first: target[1].text.delete(',').delete('百万円').to_i,
              second: target[2].text.delete(',').delete('百万円').to_i,
              third: target[3].text.delete(',').delete('百万円').to_i,
            }
          end
          if target.first.text =~ /^当期利益/
            achievement[:net_income] = {
              first: target[1].text.delete(',').delete('百万円').to_i,
              second: target[2].text.delete(',').delete('百万円').to_i,
              third: target[3].text.delete(',').delete('百万円').to_i,
            }
          end
        end

        achievement
      rescue OpenURI::HTTPError => e
        Rails.logger.info("Parser::Jpn::Achievement: #{e.message}")
      end
    end
  end
end
