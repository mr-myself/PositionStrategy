class ChangeColumnCompanyIdToCompanyNumber < ActiveRecord::Migration
  def change
    execute 'ALTER TABLE achievements CHANGE COLUMN company_id company_number INT UNSIGNED NOT NULL'
    execute 'ALTER TABLE details CHANGE COLUMN company_id company_number INT UNSIGNED NOT NULL'
    execute 'ALTER TABLE user_company_maps CHANGE COLUMN company_id company_number INT UNSIGNED NOT NULL'
  end
end
