class CreateUsAverages < ActiveRecord::Migration
  def change
    create_table :us_averages do |t|
      t.integer :us_sector_id, :null => false
      t.integer :sale
      t.integer :operating_profit
      t.integer :net_income
      t.integer :period_type

      t.timestamps
    end

    execute 'ALTER TABLE us_averages CHANGE COLUMN sale sale bigint(20)'
    execute 'ALTER TABLE us_averages CHANGE COLUMN operating_profit operating_profit bigint(20)'
    execute 'ALTER TABLE us_averages CHANGE COLUMN net_income net_income bigint(20)'
  end
end
