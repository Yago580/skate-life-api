require 'rails_helper'

RSpec.describe 'GET /skateparks' do
  it 'returns a list of all skateparks' do
    skateparks = [
      create(:skatepark), create(:skatepark, :other)]

    get '/skateparks'

    skateparks.each_with_index do |skatepark, i|
      expect(json_body[i]['id']).to eq(skatepark.id)
      expect(json_body[i]['name']).to eq(skatepark.name)
      expect(json_body[i]['address']).to eq(skatepark.address)
    end
  end
end

RSpec.describe 'GET /skateparks/:id' do
  it 'returns skatepark with proper id' do
    skateparks = [
      create(:skatepark), create(:skatepark, :other)]
    other = skateparks[-1]

    get "/skateparks/#{other.id}"

    expect(json_body['id']).to eq(other.id)
    expect(json_body['name']).to eq(other.name)
    expect(json_body['address']).to eq(other.address)
    expect(json_body['state']).to eq(other.state)
    expect(json_body['lat']).to eq(other.lat)
    expect(json_body['lon']).to eq(other.lon)
  end

  it 'returns users that have favorited skatepark' do
    skatepark = create(:skatepark)
    user = create(:user)
    create_favorite(user.id, skatepark.id)

    get "/skateparks/#{skatepark.id}"

    users_who_faved = json_body['users_who_faved']
    expect(users_who_faved[0]['name']).to eq(user.name)
    expect(users_who_faved[0]['email']).to eq(user.email)
  end
end
