class AddShippedToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :shipped, :boolean, default: false
  end
end
