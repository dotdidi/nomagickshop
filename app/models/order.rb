class Order < ApplicationRecord
  has_many :line_items
  has_many :product, through: :line_item
  belongs_to :user, optional: true
  has_one :cart
  accepts_nested_attributes_for :user
  validates :name, presence: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  validates :address, presence: true
  validate :pay_type_is_correct

  private

  def pay_type_is_correct
    errors.add(:pay_type, "is invalid") unless pay_type['Credit'] || pay_type['Transfer'] || pay_type['Cash'] || pay_type['PayPal']
  end

end
