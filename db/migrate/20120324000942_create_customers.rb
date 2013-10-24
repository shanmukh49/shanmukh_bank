class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :username
      t.string :password_digest
      t.string :full_name

      t.timestamps
    end
  end
end
