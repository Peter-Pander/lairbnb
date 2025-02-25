class BookingsController < ApplicationController
  before_action :set_flat, only: [:create] # Set the flat for the booking form

  # New booking page (form)
  def new
    @booking = Booking.new
  end

  # Create a new booking
  def create
    @booking = @flat.bookings.new(booking_params)
    @booking.user = current_user # assuming you have user authentication set up

    if @booking.save
      redirect_to flat_booking_path(@flat, @booking), notice: 'Booking was successfully created.'
    else
      render 'flats/show', alert: 'Error creating booking. Please check your inputs.'
    end
  end

  # Show booking details (confirmation)
  def show
    @booking = Booking.find(params[:id])
  end

  private

  def set_flat
    @flat = Flat.find(params[:flat_id]) # Assuming you’re passing the flat's ID to the booking form
  end

  def booking_params
    params.require(:booking).permit(:start_datetime, :end_datetime, :guests, :status)
  end
end
