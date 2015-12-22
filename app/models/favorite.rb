class Favorite < ActiveRecord::Base
  validates_uniqueness_of :user_id, scope: :skatepark_id
  belongs_to :user
  belongs_to :skatepark
end
