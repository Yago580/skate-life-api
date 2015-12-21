class SkateparksController < ApplicationController
  def index
    render json: Skatepark.all
  end

  def show
    park = Skatepark.where(id: params['id']).first
    if park
      render json: park
    else
      not_found
    end
  end

  private

  def not_found
    render json: {
      error: 'Skatepark Not Found'
    }.to_json, status: 404
  end
end
