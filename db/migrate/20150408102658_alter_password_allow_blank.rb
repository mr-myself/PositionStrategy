class AlterPasswordAllowBlank < ActiveRecord::Migration
  def change
    change_column :users, :password, :string, null: true
  end
end
