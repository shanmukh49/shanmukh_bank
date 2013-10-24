class CreateCustomerTransactions < ActiveRecord::Migration
  def change
    create_table :customer_transactions do |t|
      t.integer :customer_id
      t.integer :recipient_customer_id
      t.integer :payee_id
      t.decimal :amount
      t.date :transaction_date
      t.integer :transaction_type

      t.timestamps
    end
  end
end
