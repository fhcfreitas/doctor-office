FactoryBot.define do
  factory :user do
    name { "Dr. Freitas" }
    admin { false }
    sequence(:email_address) { |n| "test#{n}@test.com" }
    password { "password" }
    specialty { "Cardiology" }
    city { "Rio de Janeiro" }
    state { "RJ" }
    bio { "Test bio for admin user." }

    trait :admin do
      admin { true }
    end
  end
end
