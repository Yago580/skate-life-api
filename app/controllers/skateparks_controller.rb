class SkateparksController < ApplicationController
  def index
    render json: Skatepark.all
  end

  def show
    skatepark = Skatepark.find(params['id'])
    render json: skatepark.to_json(
      include: :users_who_faved)
  end
end
