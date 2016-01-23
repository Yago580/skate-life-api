require 'rails_helper'

RSpec.describe User do
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
