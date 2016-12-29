class Product < ApplicationRecord
  validates :title, presence: true, length: {maximum: 75}
  validates :desc, presence: true, length: {minimum: 6}
  validates :img_url, uniqueness: {case_sensitive: false}
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validate :image_url_is_correct

  private

  def image_url_is_correct
    errors.add(:img_url, "is invalid")  unless img_url.start_with?('https://', 'http://') && img_url.end_with?('gif', 'jpg', 'jpeg', 'png')
  end

end
