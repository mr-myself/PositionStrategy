module Parser
  module Us
    class FormatAchievement

      class << self
        def format(element)
          data = []
          (2..4).each do |number|
            if element.css("td[#{number}]").text.include?('(')
              minus_element = '-'.concat(element.css("td[#{number}]").text.delete(',').delete('(').delete(')').to_i.to_s.concat('000'))
              data << minus_element.to_i
            else
              data << element.css("td[#{number}]").text.delete(',').delete('(').delete(')').to_i.to_s.concat('000').to_i
            end
          end

          {first: data[0], second: data[1], third: data[2]}
        end
      end
    end
  end
end
