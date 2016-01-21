class User < ActiveRecord::Base
  validates_presence_of :email
  has_many :favorites
  has_many :skateparks, through: :favorites

  def self.all_with_skateparks
    User.includes(:skateparks).find_each.lazy
  end
end
