module AssociationHelpers
  def create_favorite(user_id, skatepark_id)
    create(:favorite,
           user_id: user_id, skatepark_id: skatepark_id)
  end

  RSpec.configure do |config|
    config.include AssociationHelpers
  end
end
