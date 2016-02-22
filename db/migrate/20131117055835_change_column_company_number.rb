class ChangeColumnCompanyNumber < ActiveRecord::Migration
  def change
    execute 'ALTER TABLE companies CHANGE COLUMN number company_number INT UNSIGNED NOT NULL'
  end
end
