class FlatsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @flats = Flat.all
  end

  def show
    @flat = Flat.find(params[:id])
  end

  private

  def flat_params
    params.require(:flat).permit(:photo, :name, :description, :amenities, :price_per_night, :address)
  end
end
