namespace :us_market_data do

  desc 'Create US Market Data'
  task create: :environment do
    # ENV market names are nyse or nasdaq
    market = Parser::Us::Market.new(ENV['market'])
    market.latest_list.each do |company|
      sleep 2
      begin
        company.build_data
        next unless company.bs

        company.create_or_updates
        exist_data = UsAchievement.where(symbol: company.symbol).all
        [:first, :second, :third].each.with_index(1) do |order, index|
          next if overlap?(exist_data, company, order)
          next if no_sale_and_operating_profit_data?(company, order)

          UsAchievement.increment_counter(:period_type, exist_data.pluck(:id)) if exist_data.present?
          UsAchievement.create_with(company, order, index)
          UsCompetitor.re_create(company)
        end
      rescue => e
        p e
        Rails.logger.info("Parse ERROR: #{company.symbol}: #{e}")
        DeleteCompany::Us.execute(company.symbol)
        next
      end
    end
  end

  desc 'Create Average Data'
  task create_average: :environment do
    sectors_id.each do |sector_id|
      (1..3).each do |period|
        average = AverageCalculator::Us.calculate(target_columns, period, sector_id)
        if us_average = UsAverage.find_by(sector_id: sector_id, period_type: period)
          us_average.update_attributes(
            sale:             average[:sale],
            operating_profit: average[:operating_profit],
            net_income:       average[:net_income]
          )
        else
          UsAverage.create(
            sector_id:        sector_id,
            sale:             average[:sale],
            operating_profit: average[:operating_profit],
            net_income:       average[:net_income],
            period_type:      period
          )
        end
      end
    end
  end

  def overlap?(exist_data, company, order)
    exist_data.pluck(:publish_day).include?(company.pl[:publish_day][order])
  end

  def no_sale_and_operating_profit_data?(company, order)
    company.pl[:sale][order] == 0 and company.pl[:operating_profit][order] == 0
  end

  def sectors_id
    I18n.t('us_industries.ja').map{|key, value| key.to_s}
  end

  def target_columns
    UsAverage::COLUMN
  end
end
