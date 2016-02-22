class UsAchievement < ActiveRecord::Base
  belongs_to :us_company, foreign_key: :symbol

  scope :lookup, ->(symbol) { where(symbol: symbol).order('period_type DESC') }

  class << self
    def lookup_my_company(company_number, basis)
      Company
        .joins(
          "INNER JOIN achievements ON companies.company_number = achievements.company_number",
          "INNER JOIN details ON companies.company_number = details.company_number")
        .select("#{basis} AS basis")
        .where(company_number: company_number)
        .order("period_type DESC")
    end

    def create_with(company, order, period_type)
      create!(
        symbol:                  company.symbol,
        publish_day:             company.pl[:publish_day][order],
        sale:                    company.pl[:sale][order],
        operating_profit:        company.pl[:operating_profit][order],
        net_income:              company.pl[:net_income][order],
        operating_profit_margin: company.pl[:operating_profit_margin][order],
        roa:                     company.bs[:roa][order],
        roe:                     company.bs[:roe][order],
        period_type:             period_type
      )
    end

    def latest(company_number)
      where(company_number: company_number).order('period_type ASC').first
    end
  end
end
