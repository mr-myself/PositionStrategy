class CreateUsCompetitors < ActiveRecord::Migration
  def change
    create_table :us_competitors do |t|
      t.string :my_symbol, :null => false
      t.string :other_symbol, :null => false

      t.timestamps
    end
  end
end
