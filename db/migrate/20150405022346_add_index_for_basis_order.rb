class AddIndexForBasisOrder < ActiveRecord::Migration
  def change
    add_index :achievements,    :sale
    add_index :us_achievements, :sale
    add_index :details, :market_value
  end
end
