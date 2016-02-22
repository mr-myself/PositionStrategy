class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :null => false, :size => 255
      t.string :password, :null => false, :size => 255
      t.integer :uid
      t.string :email, :size => 255
      t.timestamps

    end

    add_index :users, :name, :unique => true
    add_index :users, :uid, :unique => true
    add_index :users, :email, :unique => true
  end
end
