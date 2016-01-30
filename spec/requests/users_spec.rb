require 'rails_helper'

RSpec.describe 'GET /users' do
  it 'should return a list of all users' do
    users = create_list(:user, 2)

    get users_path

    users.each_with_index do |user, i|
      user_json = json_body[i]
      expect(user_json['id']).to eq(user.id)
      expect(user_json['email']).to eq(user.email)
      expect(user_json['name']).to eq(user.name)
    end
  end
end

RSpec.describe 'GET /users/:id' do
  it 'should return user with the corresponding :id' do
    user = create(:user)

    get user_path user

    expect(json_body['id']).to eq(user.id)
    expect(json_body['name']).to eq(user.name)
    expect(json_body['email']).to eq(user.email)
  end

  it 'should return skateparks that user has favorited' do
    user = create(:user)
    skatepark = create(:skatepark)
    create(:favorite, user_id: user.id, skatepark_id: skatepark.id)

    get user_path user

    favorited_park = json_body['favorite_parks'][0]
    expect(favorited_park['name']).to eq(skatepark.name)
    expect(favorited_park['address']).to eq(skatepark.address)
  end
end

RSpec.describe 'POST /users' do
  it 'should create and return a user' do
    user = build(:user)

    post users_path, user: user.to_json

    expect(json_body['name']).to eq(user.name)
    expect(json_body['email']).to eq(user.email)
  end

  it 'should return 422 if user cannot be created' do
    user = build(:user, :invalid)

    post users_path, user: user.to_json

    expect(response.status).to eq(422)
  end
end

RSpec.describe 'DELETE /users' do
  it 'should destroy user with the corresponding :id' do
    user = create(:user)

    delete user_path user

    expect(response.status).to eq(204)
  end
end
