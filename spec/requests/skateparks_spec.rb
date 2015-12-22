require 'rails_helper'

RSpec.describe 'GET /skateparks' do
  it 'returns a list of all skateparks' do
    tenny = create(:skatepark)
    other = create(:skatepark, :other)

    get '/skateparks'

    expect(json_body.count).to eq(2)
    expect(json_body[0]['id']).to eq(tenny.id)
    expect(json_body[0]['name']).to eq(tenny.name)
    expect(json_body[1]['id']).to eq(other.id)
    expect(json_body[1]['name']).to eq(other.name)
  end

  it 'returns users that have favorited skateparks' do
    tenny = create(:skatepark)
    other = create(:skatepark, :other)
    user = create(:user)
    tenny.users << user
    other.users << user

    get '/skateparks'

    expect(json_body[0]['users'][0]['name']).to eq(user.name)
    expect(json_body[1]['users'][0]['email']).to eq(user.email)
  end
end

RSpec.describe 'GET /skateparks/:id' do
  it 'returns skatepark with proper id' do
    create(:skatepark)
    other = create(:skatepark, :other)

    get "/skateparks/#{other.id}"

    expect(json_body['id']).to eq(other.id)
    expect(json_body['name']).to eq(other.name)
    expect(json_body['address']).to eq(other.address)
    expect(json_body['state']).to eq(other.state)
    expect(json_body['lat']).to eq(other.lat)
    expect(json_body['lon']).to eq(other.lon)
  end

  it 'returns users that have favorited skatepark' do
    park = create(:skatepark)
    user = create(:user)
    park.users << user

    get "/skateparks/#{park.id}"

    expect(json_body['users'][0]['name']).to eq(user.name)
    expect(json_body['users'][0]['email']).to eq(user.email)
  end

  it 'returns a 404 if skatepark with id is not found' do
    expected_response = { 'error' => 'Skatepark Not Found' }

    get '/skateparks/420'

    expect(json_body).to eq(expected_response)
    expect(response.status).to eq(404)
  end
end
