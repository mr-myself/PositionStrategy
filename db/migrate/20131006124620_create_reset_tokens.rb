class CreateResetTokens < ActiveRecord::Migration
  def change
    create_table :reset_tokens do |t|
      t.string :token, :null => false
      t.string :email, :null => false
      t.timestamps
    end
  end
end
