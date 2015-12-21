class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def show
    user = User.where(id: params['id']).first
    if user
      render json: user
    else
      not_found('User')
    end
  end

  def create
    user = new_user
    if user.save
      render json: user
    else
      render json: {
        error: 'Email cannot be blank'
      }.to_json, status: :bad_request
    end
  end

  def destroy
    user = User.where(id: params['id']).first
    if user
      user.destroy
      render nothing: true, status: :no_content
    else
      render json: {
        error: 'User Not Found'
      }.to_json, status: :bad_request
    end
  end

  private

  def user_params
    JSON.parse(params['user'])
  end

  def new_user
    User.new(
      name: user_params['name'],
      email: user_params['email']
    )
  end
end
