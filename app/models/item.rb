class Item < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 20 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  validate :acceptable_image

  has_one_attached :main_image

  belongs_to :user

  private

  def acceptable_image
    return unless main_image.attached?

    unless main_image.byte_size <= 1.megabyte
      errors.add(:main_image, 'is too big')
    end

    acceptable_types = ['image/jpeg', 'image/png']
    unless acceptable_types.include?(main_image.content_type)
      errors.add(:main_image, 'must be a JPEG or PNG')
    end

  end
end
