class CreateCustomerTransfers < ActiveRecord::Migration
  def change
    create_table :customer_transfers do |t|
      t.integer :customer_id
      t.integer :recipient_customer_id
      t.decimal :amount
      t.date :transfer_date

      t.timestamps
    end
  end
end
