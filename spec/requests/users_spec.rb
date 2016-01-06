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

  it 'should return skateparks favorites by users' do
    users = [create(:user), create(:user, :other)]
    skatepark = create(:skatepark)
    users.each { |user| user.skateparks << skatepark }

    get '/users'

    json_body.each do |user|
      park = user['skateparks'][0]
      expect(park['name']).to eq(skatepark.name)
      expect(park['address']).to eq(skatepark.address)
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
    user.skateparks << skatepark

    get "/users/#{user.id}"

    park = json_body['skateparks'][0]
    expect(park['name']).to eq(skatepark.name)
    expect(park['address']).to eq(skatepark.address)
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
