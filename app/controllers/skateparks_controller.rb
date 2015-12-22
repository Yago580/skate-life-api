class SkateparksController < ApplicationController
  def index
    render json: Skatepark.all.to_json(include: :users)
  end

  def show
    park = Skatepark.where(id: params['id']).first
    if park
      render json: park
    else
      not_found('Skatepark')
    end
  end
end
