class AddInfoToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :address, :text
    add_column :users, :realname, :text
    add_column :users, :phone, :string
  end
end
