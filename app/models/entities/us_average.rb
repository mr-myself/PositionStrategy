class UsAverage < ActiveRecord::Base
  scope :lookup_sector, ->(sector_id)   { where(sector_id: sector_id) }
  scope :lookup_period, ->(period_type) { where(period_type: period_type) }

  COLUMN = [:sale, :operating_profit, :net_income]
end
