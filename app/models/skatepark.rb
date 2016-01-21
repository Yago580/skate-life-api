class Skatepark < ActiveRecord::Base
  has_many :favorites
  has_many :users_who_faved,
           through: :favorites, source: :user
end
