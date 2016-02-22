class UsCompetitor < ActiveRecord::Base
  belongs_to :us_company, foreign_key: :other_symbol
  scope :lookup, ->(symbol) { where(my_symbol: symbol) }

  def self.re_create(company)
    self.transaction do
      UsCompetitor.delete_all(my_symbol: company.symbol)
      company.competitors.try(:each) do |symbol|
        UsCompetitor.create!(my_symbol: company.symbol, other_symbol: symbol)
      end
    end
  end
end
