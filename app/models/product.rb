class Product < ApplicationRecord
  before_destroy :not_referenced_by_any_line_item
  mount_uploader :image, ImageUploader
  serialize :image, JSON #if you user SQlite, add this line
  belongs_to :user, optional: true
  has_many :line_items

  validates :title, :brand, :price, :model, presence: true
  validates :description, length: { maximum: 1000, too_long: "%{count} characters is the maximum. "}
  validates :title, length: { maximum: 140, too_long: "%{count} characters is the maximum. "}
  validates :price, length: { maximum: 7}

  BRAND = %w{ Product 1 Product 2 Product 3 Product 4 Product 5 Product 6}
  FINISH = %w{ Black White Navy Blue Red Clear Satin Yellow Seafoam }
  CONDITION = %w{ New Excellent Mint Used Fair Poor }


  private
  def not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, "Line items present")
      throw :abort
    end
  end
end
