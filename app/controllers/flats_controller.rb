class FlatsController < ApplicationController
  def index
    @flats = Flat.all
  end
end

def flat_params
  params.require(:flat).permit(:photo, :name, :description, :amenities, :price_per_night, :address)
end
