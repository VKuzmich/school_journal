FactoryBot.define do
  factory :lesson do
    association :teacher
    home_task { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.sentence(word_count: 5) }
    date_at { rand(Date.current.beginning_of_week..Date.current.end_of_week) }
    number { rand(1..9)}
    association :grade
    association :subject
  end
end
