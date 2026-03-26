# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create!(
  email_address: "admin@example.com",
  password: "admin",
  admin: true,
  password_confirmation: "admin",
  name: "Admin User",
  bio: "This is the admin user.",
  city: "New York",
  state: "NY",
  specialty: "General Practitioner"
)

User.create!(
  email_address: "nonadmin@example.com",
  password: "1234",
  admin: false,
  password_confirmation: "1234",
  name: "Non-Admin User",
  bio: "This is a non-admin user.",
)
