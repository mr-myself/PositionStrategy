class RemoveColumnPeriodTypeFromAchievements < ActiveRecord::Migration
  def change
    remove_column :achievements, :period_type
  end
end
