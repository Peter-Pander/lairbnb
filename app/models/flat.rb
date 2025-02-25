class Flat < ApplicationRecord
  belongs_to :user
  has_many :bookings

  validates :name, :description, :price_per_night, :address, presence: true
  has_one_attached :photo
end
