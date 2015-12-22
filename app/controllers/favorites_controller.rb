class FavoritesController < ApplicationController
  def create
    if fav_new? && user_exists? && park_exists?
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

  def user_exists?
    User.exists?(params['id'])
  end

  def park_exists?
    Skatepark.exists?(params['park_id'])
  end
end
