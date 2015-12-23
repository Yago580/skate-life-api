require 'rails_helper'

RSpec.describe 'Skateparks' do
  context 'GET /skateparks' do
    it 'returns a list of all skateparks' do
      skateparks = create_skateparks

      get '/skateparks'

      skateparks.each_with_index do |park, i|
        expect(json_body[i]['id']).to eq(park.id)
        expect(json_body[i]['name']).to eq(park.name)
        expect(json_body[i]['address']).to eq(park.address)
      end
    end

    it 'returns users that have favorited skateparks' do
      user = create_user
      create_skateparks.each { |park| park.users << user }

      get '/skateparks'

      expect(json_body[0]['users'][0]['name']).to eq(user.name)
      expect(json_body[1]['users'][0]['email']).to eq(user.email)
    end
  end

  context 'GET /skateparks/:id' do
    it 'returns skatepark with proper id' do
      other = create_skateparks[-1]

      get "/skateparks/#{other.id}"

      expect(json_body['id']).to eq(other.id)
      expect(json_body['name']).to eq(other.name)
      expect(json_body['address']).to eq(other.address)
      expect(json_body['state']).to eq(other.state)
      expect(json_body['lat']).to eq(other.lat)
      expect(json_body['lon']).to eq(other.lon)
    end

    it 'returns users that have favorited skatepark' do
      park = create_skatepark
      user = create_user
      park.users << user

      get "/skateparks/#{park.id}"

      expect(json_body['users'][0]['name']).to eq(user.name)
      expect(json_body['users'][0]['email']).to eq(user.email)
    end

    it 'returns a 404 if skatepark with id is not found' do
      get '/skateparks/420'

      expect(response.status).to eq(404)
    end
  end
end
