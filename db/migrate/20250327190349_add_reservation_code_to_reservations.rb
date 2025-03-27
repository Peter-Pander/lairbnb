class AddReservationCodeToReservations < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :reservation_code, :string
  end
end
