class CreateUserCompanyMap < ActiveRecord::Migration
  def change
    create_table :user_company_maps do |t|
      t.integer :user_id, :null => false
      t.integer :company_id, :null => false

      t.timestamps
    end
  end
end
