class RemoveIndexToAchievements < ActiveRecord::Migration
  def change
    remove_index :achievements, :sale
    remove_index :achievements, :operating_profit
    remove_index :achievements, :ordinary_profit
    remove_index :achievements, :net_income
    remove_index :achievements, :period_type
  end
end
