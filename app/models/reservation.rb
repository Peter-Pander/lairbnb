class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :flat

  enum status: { confirmed: 0, pending: 1, rejected: 2 }

  # Validations
  validates :start_datetime, :end_datetime, :guests, presence: true
  validate :end_after_start

  before_create :set_reservation_code

  def total_price
    calculate_total_price
  end

  def reservation_code
    read_attribute(:reservation_code)
  end

  private

  # Custom validation to ensure the end date is after the start date
  def end_after_start
    return if start_datetime.blank? || end_datetime.blank?

    if end_datetime <= start_datetime
      errors.add(:end_datetime, "must be after the check-in date")
    end
  end

  def calculate_total_price
    nights = (end_datetime.to_date - start_datetime.to_date).to_i
    nights * flat.price_per_night * guests
  end

  def set_reservation_code
    # Only set if it's not already present
    self.reservation_code ||= SecureRandom.alphanumeric(7).upcase
  end
end
