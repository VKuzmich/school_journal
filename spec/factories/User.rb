FactoryBot.define do
  factory :user do
      first_name { Faker::Name.first_name }
      last_name { 'Bondar' }
      phone { '+38(023)122-2222' }
      address { "Kharkov" }
      email { Faker::Internet.email }
      password { '12345678' }

    trait :admin do
      admin { true }
    end
  end
end
