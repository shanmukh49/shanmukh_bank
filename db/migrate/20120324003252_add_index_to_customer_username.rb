class AddIndexToCustomerUsername < ActiveRecord::Migration
  def change
    add_index :customers, :username, unique: true
  end
end
