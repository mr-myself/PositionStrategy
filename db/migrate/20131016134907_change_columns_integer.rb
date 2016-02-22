class ChangeColumnsInteger < ActiveRecord::Migration
  def change
    execute 'ALTER TABLE achievements CHANGE COLUMN sale sale INT'
    execute 'ALTER TABLE achievements CHANGE COLUMN operating_profit operating_profit INT'
    execute 'ALTER TABLE achievements CHANGE COLUMN ordinary_profit ordinary_profit INT'
    execute 'ALTER TABLE achievements CHANGE COLUMN net_income net_income INT'

    execute 'ALTER TABLE details CHANGE COLUMN annual_income annual_income INT'
    execute 'ALTER TABLE details CHANGE COLUMN employee employee INT'
    execute 'ALTER TABLE details CHANGE COLUMN market_value market_value INT'
  end
end
