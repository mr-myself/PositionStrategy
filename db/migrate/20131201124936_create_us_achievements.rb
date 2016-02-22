class CreateUsAchievements < ActiveRecord::Migration
  def change
    create_table :us_achievements do |t|
      t.string :symbol, :null => false
      t.string :publish_day
      t.integer :sale
      t.integer :operating_profit
      t.integer :net_income
      t.integer :period_type
      t.integer :operating_profit_margin
      t.integer :roa
      t.integer :roe

      t.timestamps
    end

    execute 'ALTER TABLE us_achievements CHANGE COLUMN sale sale bigint(20)'
    execute 'ALTER TABLE us_achievements CHANGE COLUMN operating_profit operating_profit bigint(20)'
    execute 'ALTER TABLE us_achievements CHANGE COLUMN net_income net_income bigint(20)'
  end

end
