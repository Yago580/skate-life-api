FactoryGirl.define do
  factory :skatepark do
    name 'Tennyson'
    address '28146 Huntwood Ave, Hayward, CA 94544'
    state 'California'
    lat 37.632840
    lon(-122.064482)
    users []

    trait :other do
      name 'Other'
      address '555 Other Way Othertown CO 12345'
      lat 56.567234
      lon(-122.064482)
    end
  end

  factory :user do
    name 'swag'
    email 'swag@swag.swag'
    skateparks []

    trait :other do
      name 'swaggy'
      email 'swaggy@swaggy.swaggy'
    end

    trait :invalid do
      name 'swag'
      email nil
    end
  end
end
