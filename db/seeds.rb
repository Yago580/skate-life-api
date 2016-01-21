require 'csv'

def create_users
  60.times.map do |i|
    User.create(name: "User_#{i}", email: "user#{i}@swag.com")
  end
end

# Using this method because mapping the foreach enumerable throw
# an error on heroku
def create_parks_from_csv(path)
  parks = []
  CSV.foreach(path, headers: true) do |row|
    park = Hash[row]
    next unless park['address']

    name = park['name'] ? park['name'] : park['city']
    parks << Skatepark.create(
      name: name, address: park['address'], state: park['state'])
  end
end

def create_user_park_associations(users)
  users.length.times do |i|
    25.times do |n|
      Favorite.create(user_id: i + 1, skatepark_id: n + 1)
    end
  end
end

create_parks_from_csv("#{Rails.root}/db/skateparks.csv")
users = create_users
create_user_park_associations(users)
