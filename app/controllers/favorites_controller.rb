class FavoritesController < ApplicationController
  def create
    if !find_fav && find_user && find_skatepark(params['park_id'])
      create_fav
      send_status(:created)
    else
      send_status(:bad_request)
    end
  end

  def destroy
    fav = find_fav
    if fav
      fav.destroy
      send_status(:no_content)
    else
      send_status(:bad_request)
    end
  end

  private

  def create_fav
    Favorite.create(
      user_id: params['id'],
      skatepark_id: params['park_id'])
  end

  def find_fav
    Favorite.where(
      user_id: params['id'],
      skatepark_id: params['park_id']).first
  end
end
