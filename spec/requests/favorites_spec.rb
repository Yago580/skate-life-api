require 'rails_helper'

RSpec.describe 'POST /favorites' do
  it 'should create a favorite for corresponding park and user' do
    user = create(:user)
    skatepark = create(:skatepark)

    expect do
      post '/favorites', user_id: user.id, skatepark_id: skatepark.id
    end.to change { user.favorite_parks.count }.by(1)

    fav = Favorite.where(user_id: user.id, skatepark_id: skatepark.id).first

    expect(fav.user).to eq(user)
    expect(fav.skatepark).to eq(skatepark)
  end

  it 'should return 422 if favorite already exists' do
    user = create(:user)
    skatepark = create(:skatepark)
    user.favorite_parks << skatepark

    expect do
      post '/favorites', user_id: user.id, skatepark_id: skatepark.id
    end.to_not change { user.favorite_parks.count }
    expect(response.status).to eq(422)
  end
end

RSpec.describe 'DELETE /favorites' do
  it "should remove park from user's favorites" do
    user = create(:user)
    skatepark = create(:skatepark)
    user.favorite_parks << skatepark

    expect do
      delete "/favorite/#{user.id}/#{skatepark.id}"
    end.to change { user.favorite_parks.count }.by(-1)
    expect(response.status).to eq(204)
  end
end
