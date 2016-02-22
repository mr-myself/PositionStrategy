class DropIndustry < ActiveRecord::Migration
  def change
    drop_table :industries
  end
end
