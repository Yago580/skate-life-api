class FavoritesController < ApplicationController
  def create
    if fav_valid?
      Favorite.create(favorite_params)
    else
      send_status(:unprocessable_entity)
    end
  end

  def destroy
    Favorite.find_by(favorite_params).destroy
    send_status(:no_content)
  end

  private

  def fav_valid?
    Favorite.find_by(favorite_params).nil?
  end

  def favorite_params
    { user_id: params['user_id'],
      skatepark_id: params['skatepark_id'] }
  end
end
