class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  belongs_to :user, optional: true
  validates :quantity, numericality: {greater_than_or_equal_to: 1}
  attr_accessor :add_quantity

  def total_price
    product.price * quantity if quantity.present?
  end

end
