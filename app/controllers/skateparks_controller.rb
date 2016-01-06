class SkateparksController < ApplicationController
  def index
    parks = Skatepark.includes(:users).find_each.lazy
    render json: parks.as_json(include: { users: {} })
  end

  def show
    park = find_skatepark
    if park
      render json: park.to_json(include: :users)
    else
      send_status(:not_found)
    end
  end
end
