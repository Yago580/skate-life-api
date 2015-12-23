module ApiHelpers
  def json_body
    JSON.parse(response.body)
  end

  def create_user
    @user ||= @user = create(:user)
  end

  def create_users
    @users ||= @users = [create(:user), create(:user, :other)]
  end

  def create_skatepark
    @park ||= @park = create(:skatepark)
  end

  def create_skateparks
    @parks ||= @parks = [create(:skatepark), create(:skatepark, :other)]
  end

  RSpec.configure do |config|
    config.include ApiHelpers, type: :request
  end
end
