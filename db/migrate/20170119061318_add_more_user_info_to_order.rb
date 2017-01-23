class AddMoreUserInfoToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :ip_address, :string
    rename_column :orders, :name, :first_name
    add_column :orders, :last_name, :string
  end
end
