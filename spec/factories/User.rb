FactoryBot.define do
  factory :user do |f|
    f.first_name { Faker::Name.first_name }
    f.last_name { Faker::Name.last_name }
    f.phone { Faker::PhoneNumber.cell_phone_with_country_code }
    f.address { Faker::Address.full_address }
    f.email { Faker::Internet.email }
    f.password { '12345678' }
    f.admin { false }
  end
end
