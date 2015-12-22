class SkateparksController < ApplicationController
  def index
    render json: Skatepark.all.to_json(include: :users)
  end

  def show
    park = Skatepark.where(id: params['id']).first
    if park
      render json: park.to_json(include: :users)
    else
      not_found('Skatepark')
    end
  end
end
