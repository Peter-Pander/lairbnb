class Flat < ApplicationRecord
  belongs_to :user

  validates :name, :description, :price_per_night, :address, presence: true
end
