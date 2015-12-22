require 'rails_helper'

RSpec.describe 'POST /users/:id/favorites' do
  it 'should create a favorite for corresponding park and user' do
    park = create(:skatepark)
    user = create(:user)

    expect do
      post "/users/#{user.id}/favs", park_id: park.id
    end.to change { user.skateparks.count }.by(1)

    fav = Favorite.where(user_id: user.id, skatepark_id: park.id)
    expect(fav.first).to be_truthy
  end

  it 'should return 400 if favorite already exists' do
    park = create(:skatepark)
    user = create(:user)
    user.skateparks << park

    expect do
      post "/users/#{user.id}/favs", park_id: park.id
    end.to_not change { user.skateparks.count }
    expect(response.status).to eq(400)
  end

  it 'should return 400 if skatepark or user does not exist' do
    park = create(:skatepark)
    user = create(:user)

    expect do
      post "/users/#{user.id}/favs", park_id: 5
    end.to_not change { user.skateparks.count }
    expect(response.status).to eq(400)

    expect do
      post '/users/1/favs', park_id: park.id
    end.to_not change { user.skateparks.count }
    expect(response.status).to eq(400)
  end
end

RSpec.describe 'DELETE /users/:id/favs/:park_id' do
  it "should remove park from user's favorites" do
    park = create(:skatepark)
    user = create(:user)
    user.skateparks << park

    expect do
      delete "/users/#{user.id}/favs/#{park.id}"
    end.to change { user.skateparks.count }.by(-1)
    expect(response.status).to eq(204)
  end

  it 'should return 400 if user has not favorited park' do
    user = create(:user)

    expect do
      delete "/users/#{user.id}/favs/420"
    end.to_not change { user.skateparks.count }
    expect(response.status).to eq(400)
  end
end
