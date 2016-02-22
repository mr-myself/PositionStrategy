class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
      t.string :company_id, :null => false
      t.integer :industry_id, :null => false
      t.string :employee
      t.string :settling_day
      t.integer :age
      t.string :annual_income
      t.string :market_value

      t.timestamps
    end
  end
end
