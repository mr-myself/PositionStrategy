class ChangeColumnUid < ActiveRecord::Migration
  def change
    execute 'ALTER TABLE users CHANGE COLUMN uid uid BIGINT UNSIGNED UNIQUE'
  end
end
