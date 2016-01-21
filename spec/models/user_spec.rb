require 'rails_helper'

RSpec.describe User do
  context '.to_json_with_favorites' do
    it 'returns users with favorite_parks in json format' do
      users = [create(:user), create(:user, :other)]
      skatepark = create(:skatepark)
      users.each { |user| create_favorite(user.id, skatepark.id) }

      all_users = User.to_json_with_favorites
      first_favorite = all_users.first['favorite_parks'].first

      expect(first_favorite['address']).to eq(skatepark.address)
      expect(first_favorite['name']).to eq(skatepark.name)
      expect(first_favorite['state']).to eq(skatepark.state)
    end
  end

  context '.find_and_destroy' do
    it 'destroys a user if found' do
      user = create(:user)
      expect(User.count).to eq(1)

      User.find_and_destroy(user.id)
      expect(User.count).to eq(0)
    end

    it 'returns truthy if successful' do
      user = create(:user)

      expect(User.find_and_destroy(user.id)).to be_truthy
    end

    it 'returns nil if unsuccessful' do
      expect(User.find_and_destroy(10)).to be_falsey
    end
  end
end
