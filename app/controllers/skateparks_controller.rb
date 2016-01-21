class SkateparksController < ApplicationController
  def index
    render json: Skatepark.all
  end

  def show
    park = Skatepark.find_by_id(params['id'])
    if park
      render json: park.to_json(include: :users)
    else
      send_status(:not_found)
    end
  end
end
