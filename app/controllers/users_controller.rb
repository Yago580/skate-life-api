class UsersController < ApplicationController
  def index
    render json: User.all.to_json(include: :skateparks)
  end

  def show
    user = User.where(id: params['id']).first
    if user
      render json: user
    else
      send_status(:not_found)
    end
  end

  def create
    user = new_user
    if user.save
      render json: user
    else
      send_status(:bad_request)
    end
  end

  def destroy
    user = find_user
    if user
      user.destroy
      send_status(:no_content)
    else
      send_status(:bad_request)
    end
  end

  def favorite
    if fav_new? && user_exists? && park_exists?
      create_fav
      send_status(:created)
    else
      send_status(:bad_request)
    end
  end

  private

  def send_status(status)
    render nothing: true, status: status
  end

  def user_params
    JSON.parse(params['user'])
  end

  def find_user
    User.where(id: params['id']).first
  end

  def new_user
    User.new(
      name: user_params['name'],
      email: user_params['email']
    )
  end

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
