class Achievement < ActiveRecord::Base
  belongs_to :company, foreign_key: :company_number

  scope :lookup, ->(company_number) { where(company_number: company_number) }

  class << self

    def create_with(company)
      publish_years = lookup(company.company_number).pluck(:publish_year)
      [:first, :second, :third].each do |order|
        next if publish_years.include?(company.achievement[:publish_year][order].to_i)

        create!(
          company_number: company[:company_number],
          publish_year: company.achievement[:publish_year][order],
          publish_day: company.achievement[:publish_day][order],
          sale: company.achievement[:sale][order],
          operating_profit: company.achievement[:operating_profit][order],
          ordinary_profit: company.achievement[:ordinary_profit][order],
          net_income: company.achievement[:net_income][order]
        )
      end
    end
  end
end
