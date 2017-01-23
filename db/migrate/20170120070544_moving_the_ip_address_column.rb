class MovingTheIpAddressColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :ip_address
    add_column :transactions, :ip_address, :string
  end
end
