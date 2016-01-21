require 'rails_helper'

RSpec.describe User do
  context '.all_with_skateparks' do
    it 'returns users with associated skateparks' do
      users = [create(:user), create(:user, :other)]
      skatepark = create(:skatepark)
      users.each { |user| user.skateparks << skatepark }

      all_users = User.all_with_skateparks

      expect(all_users.to_a).to eq(users)
      expect(all_users.first.skateparks.first).
        to eq(users[0].skateparks.first)
    end
  end
end
