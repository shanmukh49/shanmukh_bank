class CreateCustomerPayments < ActiveRecord::Migration
  def change
    create_table :customer_payments do |t|
      t.integer :customer_id
      t.integer :payee_id
      t.string :account
      t.decimal :amount
      t.date :payment_date

      t.timestamps
    end
  end
end
