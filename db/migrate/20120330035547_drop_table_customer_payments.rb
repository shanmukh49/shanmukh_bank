class DropTableCustomerPayments < ActiveRecord::Migration
  def up
    drop_table :customer_payments
  end
end
