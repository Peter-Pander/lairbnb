class ReservationsController < ApplicationController
  before_action :set_flat, only: [:create] # Set the flat for the reservation form

  # New reservation page (form)
  def new
    @reservation = Reservation.new
  end

  # Create a new reservation
  def create
    @reservation = @flat.reservations.new(reservation_params)
    @reservation.user = current_user # assuming you have user authentication set up

    if @reservation.save
      redirect_to flat_reservation_path(@flat, @reservation)
    else
      render 'flats/show', alert: 'Error creating reservation. Please check your inputs.'
    end
  end

  # Show reservation details (confirmation)
  def show
    @reservation = Reservation.find(params[:id])
  end

  private

  def set_flat
    @flat = Flat.find(params[:flat_id]) # Assuming you’re passing the flat's ID to the reservation form
  end

  def reservation_params
    params.require(:reservation).permit(:start_datetime, :end_datetime, :guests)
  end
end
