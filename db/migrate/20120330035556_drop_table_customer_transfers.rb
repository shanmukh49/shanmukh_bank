class DropTableCustomerTransfers < ActiveRecord::Migration
  def up
    drop_table :customer_transfers
  end
end
