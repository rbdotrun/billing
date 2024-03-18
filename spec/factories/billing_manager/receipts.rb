FactoryBot.define do
  factory :receipt do
    association(:subscription)
  end
end
