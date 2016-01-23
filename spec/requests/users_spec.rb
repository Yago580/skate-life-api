require 'rails_helper'

RSpec.describe 'GET /users' do
  it 'should return a list of all users' do
    users = [create(:user), create(:user, :other)]

    get '/users'

    users.each_with_index do |user, i|
      expect(json_body[i]['id']).to eq(user.id)
      expect(json_body[i]['email']).to eq(user.email)
      expect(json_body[i]['name']).to eq(user.name)
    end
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
    skatepark = create(:skatepark)
    create_favorite(user.id, skatepark.id)

    get "/users/#{user.id}"

    favorited_park = json_body['favorite_parks'][0]
    expect(favorited_park['name']).to eq(skatepark.name)
    expect(favorited_park['address']).to eq(skatepark.address)
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

  it 'should return 422 if user cannot be created' do
    user = build(:user, :invalid)

    expect do
      post '/users', user: user.to_json
    end.to_not change { User.count }
    expect(response.status).to eq(422)
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
end
