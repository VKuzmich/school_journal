FactoryBot.define do
  factory :grade do
    number { rand(1..12) }
    letter { [*'A'..'Z'].sample }
  end
end
