class User < ApplicationRecord
  has_many :carts
  has_many :line_items, through: :carts
  before_save :downcase_email
  validates :username, uniqueness: true, presence: true, length: {minimum: 4}
  validates :email, presence: true, uniqueness: {case_sensitive: false}, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true
  validates :realname, allow_blank: true, length: {maximum: 50}
  validates :address, allow_blank: true, length: {minimum: 4}
  validates :phone,allow_blank: true, numericality: true, length: {minimum: 7, maximum: 14}

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def downcase_email
    self.email = email.downcase
  end

end
