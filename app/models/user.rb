class User < ApplicationRecord
  has_secure_password
  has_many :items, dependent: :destroy

  validates :name, presence: true
  validates :email, format: { with: /\S+@\S+/ }, uniqueness: { case_sensitive: false }
end
