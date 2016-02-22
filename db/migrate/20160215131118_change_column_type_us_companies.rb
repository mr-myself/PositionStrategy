class ChangeColumnTypeUsCompanies < ActiveRecord::Migration
  def change
    change_column :us_companies, :market_value, :string
  end
end
