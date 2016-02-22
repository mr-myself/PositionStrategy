class AddColumnPublishYearToAchievements < ActiveRecord::Migration
  def change
    add_column :achievements, :publish_year, :integer, after: :company_number, null: false
  end
end
