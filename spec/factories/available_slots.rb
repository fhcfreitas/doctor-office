FactoryBot.define do
  factory :available_slot do
    association :user, :admin
    starts_at { "2026-04-29 14:00:00" }
    ends_at { "2026-04-29 15:00:00" }
    status { :available }
  end
end
