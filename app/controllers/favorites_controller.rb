class FavoritesController < ApplicationController
  def create
    if fav_new? && find_user && find_skatepark(params['park_id'])
      create_fav
      send_status(:created)
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

  def fav_new?
    !Favorite.exists?(
      user_id: params['id'],
      skatepark_id: params['park_id'])
  end
end
