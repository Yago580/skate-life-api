FactoryGirl.define do
  factory :skatepark do
    name 'Tennyson'
    address '28146 Huntwood Ave, Hayward, CA 94544'
    state 'California'
    lat 37.632840
    lon(-122.064482)
    users_who_faved []
  end

  factory :user do
    sequence(:name) { |n| "person#{n}" }
    sequence(:email) { |n| "swag#{n}@swag.swag" }
    favorite_parks []

    trait :invalid do
      name 'swag'
      email nil
    end
  end

  factory :favorite do
    user_id Integer
    skatepark_id Integer
  end
end
