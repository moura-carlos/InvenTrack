class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum:3, maximum: 50 }

  before_validation :downcase_name_attribute

  has_many :item_categories, dependent: :destroy
  has_many :items, through: :item_categories

  private

  def downcase_name_attribute
    self.name = name.downcase if name.present?
  end
end
