class AddColumnCompanyType < ActiveRecord::Migration
  def change
    add_column :user_company_maps, :company_type, :integer, :null => :false, :default => 0, :after => :company_id
    execute 'ALTER TABLE user_company_maps CHANGE COLUMN company_type company_type TINYINT UNSIGNED NOT NULL DEFAULT 0'
  end
end
