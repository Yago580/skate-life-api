class FavoritesController < ApplicationController
  def create
    if Favorite.valid?(favorite_params)
      Favorite.create(favorite_params)
    else
      send_status(:unprocessable_entity)
    end
  end

  def destroy
    Favorite.destroy_all(favorite_params)
    send_status(:no_content)
  end

  private

  def favorite_params
    { user_id: params['user_id'],
      skatepark_id: params['skatepark_id'] }
  end
end
