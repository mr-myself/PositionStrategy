class CreateUsIndustries < ActiveRecord::Migration
  def change
    create_table :us_industries do |t|
      t.string :name, :null => false, :size => 255
    end
  end
end
