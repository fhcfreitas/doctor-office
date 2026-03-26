FactoryBot.define do
  factory :user do
    name { "Dr. Freitas" }
    admin { true }
    email_address { "test@test.com" }
    password { "password" }
    specialty { "Cardiology" }
    city { "Rio de Janeiro" }
    state { "RJ" }
    bio { "Test bio for admin user." }
  end
end
