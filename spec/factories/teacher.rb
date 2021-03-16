FactoryBot.define do
  factory :teacher do
    association :subject
    association :user
  end
end