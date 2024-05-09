# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "\n== Creating admins =="

User.find_or_create_by!(
  name: "Bowser Koopa",
  email: "bowser@test.com"
) do |user|
  user.password = "secretpw"
  user.password_confirmation = "secretpw"
  # user.administrator = true
  user.save!
end

puts "\n== Creating users =="

User.find_or_initialize_by(
  name: "Louise Sawyer",
  email: "lousie@test.com"
) do |user|
  user.password = "secretpw"
  user.password_confirmation = "secretpw"
end.save!

User.find_or_create_by!(
  name: "Thelma Dickinson",
  email: "thelma@test.com"
) do |user|
  user.password = "secretpw"
  user.password_confirmation = "secretpw"
end.save!
