class User < ActiveRecord::Base
  validates_presence_of :email
  has_many :favorites
  has_many :skateparks, through: :favorites
end
