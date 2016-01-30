FactoryGirl.define do
  factory :skatepark do
    name 'Tennyson'
    address '28146 Huntwood Ave, Hayward, CA 94544'
    state 'California'
    lat 37.632840
    lon(-122.064482)
    users_who_faved []

    trait :other do
      name 'Other'
      address '555 Other Way Othertown CO 12345'
      lat 56.567234
      lon(-122.064482)
    end
  end

  factory :user do
    sequence(:name) { |n| "person#{n}" }
    sequence(:email) { |n| "swag#{n}@swag.swag" }
    favorite_parks []

    trait :other do
      name 'swaggy'
      email 'swaggy@swaggy.swaggy'
    end

    trait :invalid do
      name 'swag'
      email nil
    end
  end

  factory :favorite do
    sequence(:user_id)
    sequence(:skatepark_id)
  end
end
