class AddOrderToTransaction < ActiveRecord::Migration[5.0]
  def change
    add_reference :transactions, :order, foreign_key: true
  end
end
