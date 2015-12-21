require 'csv'

CSV.foreach("#{Rails.root}/db/skateparks.csv", headers: true) do |row|
  park = Hash[row]
  next unless park['address']

  name = park['name'] ? park['name'] : park['city']
  Skatepark.create(name: name, address: park['address'], state: park['state'])
end
