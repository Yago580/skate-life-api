require 'rails_helper'

RSpec.describe 'GET /skateparks' do
  it 'returns a list of all skateparks' do
    skateparks = create_list(:skatepark, 2)

    get skateparks_path

    skateparks.each_with_index do |skatepark, i|
      expect(json_body[i]['id']).to eq(skatepark.id)
      expect(json_body[i]['name']).to eq(skatepark.name)
      expect(json_body[i]['address']).to eq(skatepark.address)
    end
  end
end

RSpec.describe 'GET /skateparks/:id' do
  it 'returns skatepark with proper id' do
    skatepark = create(:skatepark)

    get skatepark_path skatepark

    expect(json_body['id']).to eq(skatepark.id)
    expect(json_body['name']).to eq(skatepark.name)
    expect(json_body['address']).to eq(skatepark.address)
    expect(json_body['state']).to eq(skatepark.state)
    expect(json_body['lat']).to eq(skatepark.lat)
    expect(json_body['lon']).to eq(skatepark.lon)
  end

  it 'returns users that have favorited skatepark' do
    skatepark = create(:skatepark)
    user = create(:user)
    create(:favorite, user_id: user.id, skatepark_id: skatepark.id)

    get skatepark_path skatepark

    users_who_faved = json_body['users_who_faved']
    expect(users_who_faved[0]['name']).to eq(user.name)
    expect(users_who_faved[0]['email']).to eq(user.email)
  end
end
