class Detail < ActiveRecord::Base
  belongs_to :company, foreign_key: :company_number

  scope :lookup_industry, ->(industry_id)    { where(industry_id: industry_id) }

  class << self
    def order_by_similar_market_value(detail)
      order("ABS(details.market_value - #{detail.market_value})")
    end

    def exclude_me(company_number)
      where.not(company_number: company_number)
    end

    def create_or_update_with(company)
      find_by(company_number: company[:company_number]) ? update_with(company) : create_with(company)
    end

    def create_with(company)
      create!(
        company_number: company[:company_number],
        industry_id: company.detail[:base_info][:industry],
        settling_day: company.detail[:base_info][:settling_day],
        employee: company.detail[:base_info][:employee],
        age: company.detail[:base_info][:age],
        annual_income: company.detail[:base_info][:annual_income],
        market_value: company.detail[:market_value]
      )
    end

    def update_with(company)
      find_by(company_number: company[:company_number])
        .update(
          industry_id: company.detail[:base_info][:industry],
          settling_day: company.detail[:base_info][:settling_day],
          employee: company.detail[:base_info][:employee],
          age: company.detail[:base_info][:age],
          annual_income: company.detail[:base_info][:annual_income],
          market_value: company.detail[:market_value]
        )
    end
  end
end
