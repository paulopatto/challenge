class Api::RestaurantsController < ApplicationController
  def index
    restaurants_scope = Restaurant.all

    if params[:culinaryId].present?
      restaurants_scope = culinary_filter(restaurants_scope, params[:culinaryId].to_i)
    end

    if params[:date].present? && params[:seats].present?
      restaurants_scope = seats_available_filter(restaurants_scope, params[:date].to_date, params[:seats].to_i)
    end

    render json: restaurants_scope, except: %i[id created_at updated_at]
  end

  private

  def culinary_filter(scope, culinary_id = params[:culinaryId])
    scope.by_culinary(culinary_id.to_i)
  end

  def seats_available_filter(scope, date, seats)
    scope.with_seats_available(date.to_date, seats.to_i)
  end
end
