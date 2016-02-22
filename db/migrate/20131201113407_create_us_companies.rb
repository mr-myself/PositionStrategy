class CreateUsCompanies < ActiveRecord::Migration
  def change
    create_table :us_companies do |t|
      t.integer :sector_id, :null => false
      t.integer :industry_id, :null => false
      t.string  :name, :null => false
      t.string  :symbol, :null => false
      t.integer :market_type
      t.integer :market_value

      t.timestamps
    end

    execute 'ALTER TABLE us_companies CHANGE COLUMN market_value market_value bigint(20)'
  end
end
