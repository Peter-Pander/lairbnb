# app/helpers/reservations_helper.rb
module ReservationsHelper
  def reservation_nights(reservation)
    return 0 unless reservation.start_datetime && reservation.end_datetime

    (reservation.end_datetime.to_date - reservation.start_datetime.to_date).to_i
  end
end
