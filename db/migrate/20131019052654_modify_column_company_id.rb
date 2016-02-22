class ModifyColumnCompanyId < ActiveRecord::Migration
  def change
    execute 'ALTER TABLE details MODIFY company_id INT UNSIGNED NOT NULL'
  end
end
