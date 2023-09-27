FactoryBot.define do
  factory :user do
      first_name { Faker::Name.last_name.gsub(/\W/, '').gsub('u0000', '') }
      last_name { Faker::Name.last_name.gsub(/\W/, '').gsub('u0000', '') }
      phone { '+38(023)122-2222' }
      address { 'Taxes Temple' }
      email { Faker::Internet.email }
      password { Faker::Internet.password(min_length: 6, max_length: 20) }

    trait :admin do
      admin { true }
    end
  end
end
