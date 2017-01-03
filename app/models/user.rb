class User < ApplicationRecord
  has_many :carts
  before_save :downcase_email
  validates :username, presence: true, length: {minimum: 4}
  validates :email, presence: true, uniqueness: {case_sensitive: false}, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def downcase_email
    self.email = email.downcase
  end

end
