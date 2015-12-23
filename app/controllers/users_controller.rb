class UsersController < ApplicationController
  def index
    users = User.includes(:skateparks).find_each.lazy
    render json: users.as_json(include: { skateparks: {} })
  end

  def show
    user = find_user
    if user
      render json: user.to_json(include: :skateparks)
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

  private

  def user_params
    JSON.parse(params['user'])
  end

  def new_user
    User.new(
      name: user_params['name'],
      email: user_params['email'])
  end
end
