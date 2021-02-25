FactoryBot.define do
  factory :subject do |f|
      f.name { Faker::Educator.subject }
  end
end