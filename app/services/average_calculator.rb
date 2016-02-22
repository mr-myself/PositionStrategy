module AverageCalculator

  class Jpn
    class << self
      def annual_average_in(industry_id, year:)
        Company
          .joins(:details, :achievements)
          .select(%Q|
            TRUNCATE(AVG(achievements.sale), 0) AS avg_sale,
            TRUNCATE(AVG(achievements.operating_profit), 0) AS avg_operating_profit,
            TRUNCATE(AVG(achievements.ordinary_profit), 0) AS avg_ordinary_profit,
            TRUNCATE(AVG(achievements.net_income), 0) AS avg_net_income,
            TRUNCATE(AVG(details.market_value), 0) AS avg_market_value,
            TRUNCATE(AVG(details.employee), 0) AS avg_employee,
            TRUNCATE(AVG(details.annual_income), 0) AS avg_annual_income,
            TRUNCATE(AVG(details.age), 0) AS avg_age
          |)
          .where("details.industry_id = #{industry_id} AND achievements.publish_year = #{year}")
          .first
      end

      def each_years_average_in(industry_id, years)
        [].tap do |t|
          years.each do |year|
            t << Company.joins(:details, :achievements)
              .select(%Q|
                TRUNCATE(AVG(achievements.sale), 0) AS avg_sale,
                TRUNCATE(AVG(achievements.operating_profit), 0) AS avg_operating_profit,
                TRUNCATE(AVG(achievements.ordinary_profit), 0) AS avg_ordinary_profit,
                TRUNCATE(AVG(achievements.net_income), 0) AS avg_net_income,
                TRUNCATE(AVG(details.market_value), 0) AS avg_market_value,
                TRUNCATE(AVG(details.employee), 0) AS avg_employee,
                TRUNCATE(AVG(details.annual_income), 0) AS avg_annual_income,
                TRUNCATE(AVG(details.age), 0) AS avg_age
              |)
              .where("details.industry_id = #{industry_id} AND achievements.publish_year = #{year}").first
          end
        end
      end
    end
  end

  class Us

    def self.calculate(columns, period, sector_id)
      average_calculator = new(period, sector_id)
      average_calculator.build(columns)
    end

    def initialize(period, sector_id)
      @period = period
      @sector_id = sector_id
    end

    def build(columns)
      {}.tap do |average|
        columns.map{|column| average[column] = query(column) }
      end
    end

    def query(column)
      UsCompany
        .joins(%Q{
          INNER JOIN us_achievements
          ON us_companies.symbol = us_achievements.symbol
        })
        .select("TRUNCATE(AVG(#{column}), 0) AS avg")
        .where(sector_id: @sector_id)
        .where("us_achievements.period_type = #{@period}")
        .first.avg
    end
  end
end
