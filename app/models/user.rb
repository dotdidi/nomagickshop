class User < ApplicationRecord
  before_save :downcase_email
  validates :username, presence: true, length: {minimum: 4}, uniqueness: true
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: {case_sensitive: false}
  has_secure_password

  private

  def downcase_email
    self.email = email.downcase
  end

end
