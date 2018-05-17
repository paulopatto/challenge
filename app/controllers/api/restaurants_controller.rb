class Api::RestaurantsController < ApplicationController
  def index
    @results = params[:culinaryId].present? ? filtered_list : Restaurant.all
    render json: @results
  end

  private

  def filtered_list
    Restaurant.joins(:culinaries).where({culinaries: { id: params[:culinaryId] }})
  end

  def filter(restaurants)
    restaurants.select do |restaurant|
      restaurant.culinary_ids.include?(params[:culinaryId].to_i)
    end
  end
end
