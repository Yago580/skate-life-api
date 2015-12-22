class SkateparksController < ApplicationController
  def index
    render json: Skatepark.all.to_json(include: :users)
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
