class UsersController < ApplicationController
  def index
    render json: User.all_with_skateparks.
      as_json(include: { skateparks: {} })
  end

  def show
    user = User.find_by_id(params['id'])
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
    user = User.find_by_id(params['id'])
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
