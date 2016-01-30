class User < ActiveRecord::Base
  validates_presence_of :email
  has_many :favorites
  has_many :favorite_parks,
           through: :favorites, source: :skatepark
end
