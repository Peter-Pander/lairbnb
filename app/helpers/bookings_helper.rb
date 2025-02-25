module BookingsHelper
  def booking_nights(booking)
    return 0 unless booking.start_datetime && booking.end_datetime

    (booking.end_datetime.to_date - booking.start_datetime.to_date).to_i
  end
end
