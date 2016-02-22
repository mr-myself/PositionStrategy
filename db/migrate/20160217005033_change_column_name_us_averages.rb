class ChangeColumnNameUsAverages < ActiveRecord::Migration
  def change
    rename_column :us_averages, :us_sector_id, :sector_id
  end
end
