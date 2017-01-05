class Cart < ApplicationRecord
  has_many :line_items
  has_many :products, through: :line_items
  belongs_to :user, optional: true

  def total_price
    line_items.to_a.sum{|item| item.total_price}
  end
end
