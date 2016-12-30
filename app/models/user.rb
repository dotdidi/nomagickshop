class User < ApplicationRecord
  before_save { email.downcase!}
  validates :username, presence: true, uniqueness: true, length: {minimum: 4}
  validates :email, presence: true, uniqueness: {case_sensitive: false}, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

end
