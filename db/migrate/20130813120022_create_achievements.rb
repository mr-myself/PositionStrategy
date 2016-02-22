class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.integer :company_id, :null => false
      t.string :publish_day
      t.string :sale
      t.string :operating_profit
      t.string :ordinary_profit
      t.string :net_income

      t.timestamps
    end
  end
end
