class Product < ApplicationRecord
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  validates :title, presence: true, length: {maximum: 75}
  validates :desc, presence: true, length: {minimum: 6}
  validates :img_url, uniqueness: {case_sensitive: false}
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validate :image_url_is_correct

  private

  def image_url_is_correct
    errors.add(:img_url, "is invalid")  unless img_url.start_with?('https://', 'http://') && img_url.end_with?('gif', 'jpg', 'jpeg', 'png')
  end

  def ensure_not_referenced_by_any_line_item 
    unless line_items.empty?
      errors.add(:base,'Line Items present')
      throw :abort
    end
  end

end
