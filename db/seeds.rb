# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

hash = {
  'badge_CreatedFirstSet' => 'Set builder',
  'badge_EarlyBird' => 'Early bird',
  'badge_NightOwl' => 'Night Owl',
  'badge_Overachiever' => 'Overachiever',
  'badge_StudiedWithFlashcards' => 'Flashcard whiz',
  'badge_StudiedWithLearn' => 'Active learner',
  'badge_StudiedWithTest' => 'Test acer'
}

hash.each do |key, value|
  Achievement.find_or_create_by!(image: key, title: value)
end

AdminUser.create!(email: 'admin@example.com', password: 'password1234', password_confirmation: 'password1234') if Rails.env.development?
