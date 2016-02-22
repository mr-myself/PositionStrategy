class Company < ActiveRecord::Base
  has_many :details,           primary_key: :company_number, foreign_key: :company_number
  has_many :achievements,      primary_key: :company_number, foreign_key: :company_number
  has_many :user_company_maps, primary_key: :company_number, foreign_key: :company_number
  has_many :users,             through:     :user_company_maps

  scope :lookup, ->(name)        { where('name like ?', '%' + name + '%') }
  scope :market, ->(market_type) { where(market_type: market_type) }

  class << self
    def delete_not_market(new_list)
      exists = Company
        .market(new_list.first.market_type)
        .pluck(:company_number)
      new_list.each do |company|
        if exists.include?(company[:company_number])
          exists.delete(company[:company_number]) and next
        end
      end

      exists.map{|n| DeleteCompany::Jpn.execute(n) }
    end
  end

  attr_accessor :achievement, :detail

  def build_data
    @achievement = Parser::Jpn::Achievement.get(self.company_number)
    @detail = Parser::Jpn::Detail.get(self.company_number)
  end

  def create_with_detail_and_achievement
    ActiveRecord::Base.transaction do
      Achievement.create_with(self)
      Detail.create_or_update_with(self)
      self.save! unless Company.find_by(company_number: self.company_number)
    end
  end
end
