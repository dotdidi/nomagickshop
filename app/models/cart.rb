class Cart < ApplicationRecord
  has_many :line_items
  has_many :products, through: :line_items
  has_one :order
  belongs_to :user, optional: true
  accepts_nested_attributes_for :line_items

  def total_price
    line_items.to_a.sum{|item| item.total_price}
  end

  def add_product(product, add_quantity)
    @line_item = line_items.where(product_id: product.id).take
    if @line_item.present?
      @line_item.quantity = add_quantity + @line_item.quantity
    else
      @line_item = line_items.build(product_id: product.id, quantity: add_quantity)
    end
    @line_item.save
  end
end
