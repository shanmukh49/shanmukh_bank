class AddAccountBalanceToCustomer < ActiveRecord::Migration
  def up
    add_column :customers, :account_balance, :decimal
  end

  def down
    remove_column :customers, :account_balance
  end

end
