class AddColumnAchievements < ActiveRecord::Migration
  def change
    add_column :achievements, :period_type, :integer, :after => :net_income
  end
end
