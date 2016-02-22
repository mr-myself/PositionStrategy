class AddIndexCompanyNumber < ActiveRecord::Migration
  def change
    add_index :achievements, :company_number
    add_index :details, :company_number
    add_index :companies, :company_number
  end
end
