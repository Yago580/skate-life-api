class UsersController < ApplicationController
  def index
    render json: User.to_json_with_favorites
  end

  def show
    user = User.find(params['id'])
    render json: user.to_json(
      include: :favorite_parks)
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      send_status(:unprocessable_entity)
    end
  end

  def destroy
    User.destroy(params['id'])
    send_status(:no_content)
  end

  private

  def user_params
    { name: JSON.parse(params['user'])['name'],
      email: JSON.parse(params['user'])['email'] }
  end
end
