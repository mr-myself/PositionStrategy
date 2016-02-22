class UsCompany < ActiveRecord::Base
  has_many :us_achievements, foreign_key: :symbol
  has_many :us_competitors,  foreign_key: :symbol

  scope :lookup,        ->(name)        { where('name like ?', '%' + name + '%') }
  scope :refine_sector, ->(sector_id)   { where(sector_id: sector_id) }
  scope :market,        ->(market_type) { where(market_type: market_type) }
  scope :nyse,          ->()            { where(market_type: 1) }
  scope :nasdaq,        ->()            { where(market_type: 2) }

  attr_accessor :pl, :bs, :competitors

  class << self
    def delete_not_market(new_list, market_name)
      exist_symbols = UsCompany.send(market_name).pluck(:symbol)
      new_list.each do |company|
        if exist_symbols.include?(company.symbol)
          exist_symbols.delete(company.symbol) and next
        end
      end
      exist_symbols.map{|n| DeleteCompany::Us.execute(n) } unless exist_symbols.empty?
    end

    def similar_companies(company, count)
      self
        .refine_sector(company.sector_id)
        .where.not(symbol: company.symbol)
        .order('RAND()')
        .limit(count)
        #.order("ABS(us_companies.market_value - #{company.market_value})")
    end
  end

  def build_data
    @pl = Parser::Us::ProfitAndLoss.get(self.symbol)
    @bs = Parser::Us::BalanceSheet.get(self.symbol, @pl)
    @competitors = Parser::Us::Competitor.get(self.symbol)
  end

  def create_or_updates
    if company = UsCompany.find_by(symbol: self.symbol)
      company.update_attributes(
        name:         self.name,
        sector_id:    self.sector_id,
        industry_id:  self.industry_id,
        market_value: self.market_value
      )
    else
      save
    end
  end
end
