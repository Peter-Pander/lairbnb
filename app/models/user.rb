class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  enum role: { tenant: 0, landlord: 1 }
  has_many :flats, dependent: :destroy

  validates :name, presence: true
  has_one_attached :photo

  has_many :questions
end
