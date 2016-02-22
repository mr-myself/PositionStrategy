class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string  :name, :null => false
      t.integer :number, :null => false
      t.integer :market_type
      t.timestamps
    end
  end
end
