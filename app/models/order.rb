class Order < ApplicationRecord
  has_many :line_items
  has_many :product, through: :line_item
  belongs_to :user, optional: true
  belongs_to :cart
  has_many :transactions
  accepts_nested_attributes_for :user
  validates :first_name, presence: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  validates :address, presence: true
  validate :pay_type_is_correct


  def ship_the_order
    update_attribute(:shipped, true)
  end

  def total_price
    line_items.to_a.sum{|item| item.total_price}
  end

  private

  def pay_type_is_correct
    errors.add(:pay_type, "is invalid") unless pay_type['Credit'] || pay_type['Transfer'] || pay_type['Cash'] || pay_type['PayPal']
  end

end
