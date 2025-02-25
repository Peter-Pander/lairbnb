class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :flat

  enum status: { confirmed: 0, pending: 1, rejected: 2 }

  # Validations
  validates :start_datetime, :end_datetime, :guests, presence: true
  validate :end_after_start

  private

  # Custom validation to ensure the end date is after the start date
  def end_after_start
    return if start_datetime.blank? || end_datetime.blank?

    if end_datetime <= start_datetime
      errors.add(:end_datetime, "must be after the check-in date")
    end
  end
end
