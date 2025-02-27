class FlatsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @flats = Flat.all.order(:id) # This ensures the flats are displayed in the same order as they were created.
  end

  def show
    @flat = Flat.find(params[:id])
    @booking = Booking.new # Add this line to prevent @booking from being nil
    # Add coordinates for map display (geocoding happens for the specific flat)
    @markers = [{
      lat: @flat.latitude,
      lng: @flat.longitude,
      info_window_html: render_to_string(partial: "info_window", locals: {flat: @flat})
    }]
  end

  private

  def flat_params
    params.require(:flat).permit(:photo, :name, :description, :amenities, :price_per_night, :address)
  end
end
