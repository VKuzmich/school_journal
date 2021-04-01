FactoryBot.define do
  factory :lesson do
    association :teacher
    home_task { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.sentence(word_count: 5) }
    date_at { Faker::Date.forward }
    association :grade
    association :subject
  end
end
