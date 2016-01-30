require 'rails_helper'

RSpec.describe 'POST /favorites' do
  it 'should create a favorite for corresponding park and user' do
    user = create(:user)
    skatepark = create(:skatepark)

    post favorites_path, user_id: user.id, skatepark_id: skatepark.id

    expect(Favorite.last.user).to eq(user)
    expect(Favorite.last.skatepark).to eq(skatepark)
  end

  it 'should return 422 if favorite already exists' do
    user = create(:user)
    skatepark = create(:skatepark)
    create(:favorite, user_id: user.id, skatepark_id: skatepark.id)

    post favorites_path, user_id: user.id, skatepark_id: skatepark.id

    expect(response.status).to eq(422)
  end
end

RSpec.describe 'DELETE /favorites' do
  it "should remove park from user's favorites" do
    user = create(:user)
    skatepark = create(:skatepark)
    create(:favorite, user_id: user.id, skatepark_id: skatepark.id)

    delete "/favorite/#{user.id}/#{skatepark.id}"

    expect(response.status).to eq(204)
  end
end
