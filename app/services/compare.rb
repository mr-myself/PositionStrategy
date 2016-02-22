module Compare

  class Jpn

    def self.set(base_publish_days, compare_data)
      bases = [:sale, :operating_profit, :ordinary_profit, :net_income]
      { sale: [], operating_profit: [], ordinary_profit: [], net_income: [] }.tap do |h|
        base_publish_days.each do |publish_day|
          if year = publish_day.match(/([0-9]+?)年(.+)$/)
            compare = compare_data.where("publish_day like ? ", "%#{year[1]}%").first
            bases.map{|basis| h[basis] << (compare.blank? ? nil : compare[basis])}
          end
        end
      end
    end
  end

  class Us

    def self.set(base_publish_days, compare_data)
      bases = [:sale, :operating_profit, :net_income]
      { sale: [], operating_profit: [], net_income: [] }.tap do |h|
        base_publish_days.each do |publish_day|
          if year = publish_day.match(/^(.+?),\s([0-9]+?)$/)
            compare = compare_data.where("publish_day like ? ", "%#{year[2]}%").first
            bases.map{|basis| h[basis] << (compare.blank? ? nil : compare[basis])}
          end
        end
      end
    end
  end
end
