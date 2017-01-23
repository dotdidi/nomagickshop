class AddPurchasedAtToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :purchased_at, :datetime
  end
end
