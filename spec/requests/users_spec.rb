require 'rails_helper'

RSpec.describe 'GET /users' do
  it 'should return a list of all users' do
    user = create(:user)
    other = create(:user, :other)

    get '/users'

    expect(json_body.count).to eq(2)
    expect(json_body[0]['id']).to eq(user.id)
    expect(json_body[0]['email']).to eq(user.email)
    expect(json_body[0]['name']).to eq(user.name)
    expect(json_body[1]['id']).to eq(other.id)
    expect(json_body[1]['name']).to eq(other.name)
  end

  it 'should return skateparks favorites by users' do
    user = create(:user)
    other = create(:user, :other)
    park = create(:skatepark)
    user.skateparks << park
    other.skateparks << park

    get '/users'

    expect(json_body[0]['skateparks'][0]['name']).
      to eq(park.name)
    expect(json_body[1]['skateparks'][0]['address']).
      to eq(park.address)
  end
end

RSpec.describe 'GET /users/:id' do
  it 'should return user with the corresponding :id' do
    user = create(:user)

    get "/users/#{user.id}"

    expect(json_body['id']).to eq(user.id)
    expect(json_body['name']).to eq(user.name)
    expect(json_body['email']).to eq(user.email)
  end

  it 'should return skateparks that user has favorited' do
    user = create(:user)
    park = create(:skatepark)
    user.skateparks << park

    get "/users/#{user.id}"

    expect(json_body['skateparks'][0]['name']).to eq(park.name)
    expect(json_body['skateparks'][0]['address']).to eq(park.address)
  end

  it 'should return 404 if user cannot be found' do
    get '/users/420'

    expect(response.status).to eq(404)
  end
end

RSpec.describe 'POST /users' do
  it 'should create and return a user' do
    user = build(:user)

    expect do
      post '/users', user: user.to_json
    end.to change { User.count }.by(1)
    expect(json_body['name']).to eq(user.name)
    expect(json_body['email']).to eq(user.email)
  end

  it 'should return 400 if user cannot be created' do
    user = build(:user, :invalid)

    expect do
      post '/users', user: user.to_json
    end.to_not change { User.count }
    expect(response.status).to eq(400)
  end
end

RSpec.describe 'DELETE /users' do
  it 'should destroy user with the corresponding :id' do
    user = create(:user)

    expect do
      delete "/users/#{user.id}"
    end.to change { User.count }.by(-1)
    expect(response.status).to eq(204)
  end

  it 'should return 400 if user does not exist' do
    expect do
      delete '/users/420'
    end.to_not change { User.count }
    expect(response.status).to eq(400)
  end
end

RSpec.describe 'POST /users/:id/favorites' do
  it 'should create a favorite for corresponding park and user' do
    park = create(:skatepark)
    user = create(:user)

    expect do
      post "/users/#{user.id}/favorites", park_id: park.id
    end.to change { user.skateparks.count }.by(1)

    fav = Favorite.where(user_id: user.id, skatepark_id: park.id)
    expect(fav.first).to be_truthy
  end

  it 'should return 400 if favorite already exists' do
    park = create(:skatepark)
    user = create(:user)
    user.skateparks << park

    expect do
      post "/users/#{user.id}/favorites", park_id: park.id
    end.to_not change { user.skateparks.count }
    expect(response.status).to eq(400)
  end

  it 'should return 400 if skatepark or user does not exist' do
    park = create(:skatepark)
    user = create(:user)

    expect do
      post "/users/#{user.id}/favorites", park_id: 5
    end.to_not change { user.skateparks.count }
    expect(response.status).to eq(400)

    expect do
      post '/users/1/favorites', park_id: park.id
    end.to_not change { user.skateparks.count }
    expect(response.status).to eq(400)
  end
end
