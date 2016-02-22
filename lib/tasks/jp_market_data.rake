namespace :jp_market_data do

  desc 'Create Japanese Market Data'
  task create: :environment do
    # ENV market names are tosho_first, tosho_second or mothers
    market = Parser::Jpn::Market.new(ENV['market'])
    companies = market.latest_list

    companies.each do |company|
      sleep 2
      begin
        company.build_data
        company.create_with_detail_and_achievement
      rescue => e
        DeleteCompany::Jpn.execute(company.company_number)
        Rails.logger.info("jp_market_data:create: #{e.message}")
        next
      end
    end
  end
end
