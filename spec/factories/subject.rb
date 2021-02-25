FactoryBot.define do
  factory :subject do
    sequence(:id) { |n| n }
    sequence(:name) { |n| "Math#{n}" }
  end
end