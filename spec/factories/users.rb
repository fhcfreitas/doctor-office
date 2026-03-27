FactoryBot.define do
  factory :user do
    name { "Dr. Freitas" }
    admin { true }
    sequence(:email_address) { |n| "test#{n}@test.com" }
    password { "password" }
    specialty { "Cardiology" }
    city { "Rio de Janeiro" }
    state { "RJ" }
    bio { "Test bio for admin user." }
  end
end
