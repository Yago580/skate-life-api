class User < ActiveRecord::Base
  validates_presence_of :email
  has_many :favorites
  has_many :favorite_parks,
           through: :favorites, source: :skatepark

  def self.find_and_destroy(id)
    (user = find_by_id(id)) && user.destroy
  end
end
