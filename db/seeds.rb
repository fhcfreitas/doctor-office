# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

admin = User.create!(
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

20.times do |i|
  Post.create!(
    user: admin,
    title: "Post #{i + 1}: Dicas de Saúde e Bem-estar",
    subtitle: "Aprenda algo importante sobre sua saúde ##{i + 1}",
    content: <<~TEXT,
      Este é o conteúdo do post número #{i + 1}.

      Aqui você pode escrever sobre diversos temas como:
      - Prevenção de doenças
      - Alimentação saudável
      - Importância de check-ups regulares
      - Qualidade de vida

      Manter hábitos saudáveis é essencial para uma vida longa e equilibrada.
    TEXT
    draft: [ true, false ].sample,
    newsletter_flag: false,
    newsletter_sent: false,
    published_at: rand(1..30).days.ago
  )
end
