FactoryBot.define do
  factory :student do
    association :user
    association :grade
    association :parent
    birthday { Faker::Date.birthday }
  end
end
