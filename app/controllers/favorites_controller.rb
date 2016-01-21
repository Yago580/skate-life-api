class FavoritesController < ApplicationController
  def create
    if fav_valid?
      create_favorite
      send_status(:created)
    else
      send_status(:bad_request)
    end
  end

  def destroy
    favorite = find_favorite
    if favorite
      favorite.destroy
      send_status(:no_content)
    else
      send_status(:bad_request)
    end
  end

  private

  def fav_valid?
    !find_favorite &&
      User.find_by_id(params['user_id']) &&
      Skatepark.find_by_id(params['skatepark_id'])
  end

  def create_favorite
    Favorite.create(
      user_id: params['user_id'],
      skatepark_id: params['skatepark_id'])
  end

  def find_favorite
    Favorite.where(
      user_id: params['user_id'],
      skatepark_id: params['skatepark_id']).first
  end
end
