class AddCreditCardInfoToTransaction < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :card_type, :string
    add_column :transactions, :card_expires_on, :date
  end
end
