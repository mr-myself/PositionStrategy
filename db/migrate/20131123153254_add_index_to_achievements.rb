class AddIndexToAchievements < ActiveRecord::Migration
  def change
    add_index :achievements, :sale
    add_index :achievements, :operating_profit
    add_index :achievements, :ordinary_profit
    add_index :achievements, :net_income
    add_index :achievements, :period_type
  end
end
