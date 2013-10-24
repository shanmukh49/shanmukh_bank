class RenameCustomerFullNameToName < ActiveRecord::Migration
  def change
    rename_column :customers, :full_name, :name
  end
end
