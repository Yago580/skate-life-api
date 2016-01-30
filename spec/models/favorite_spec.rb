require 'rails_helper'

RSpec.describe Favorite, type: :model do
  context '.valid?' do
    it 'returns true if favorite can be created' do
      user = create(:user)
      skatepark = create(:skatepark)
      params = { user_id: user.id, skatepark_id: skatepark.id }

      expect(Favorite.valid?(params)).to eq(true)
    end

    it 'returns false if favorite cannot be created' do
      user = create(:user)
      skatepark = create(:skatepark)
      create(:favorite, user_id: user.id, skatepark_id: skatepark.id)
      params = { user_id: user.id, skatepark_id: skatepark.id }

      expect(Favorite.valid?(params)).to eq(false)
    end
  end
end
