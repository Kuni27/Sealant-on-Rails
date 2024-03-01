# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb
email_list = [
  { email: 'jdr@tamu.edu', role: 'Admin' },
  { email: 'sushant.shelar@tamu.edu', role: 'Admin' },
  { email: 'mpanda27@tamu.edu', role: 'Admin' },
  { email: 'amal0127@tamu.edu', role: 'Admin' },
  { email: 'lovekamp@tamu.edu', role: 'Admin' },
  { email: 'sgullion@tamu.edu', role: 'Admin' },
  { email: 'jaynehete@tamu.edu', role: 'Admin' },
  { email: 'apurva.mandalika@tamu.edu', role: 'Admin' }
]

# db/seeds.rb
email_list.each do |entry|
  Whitelist.find_or_create_by!(email: entry[:email]) do |whitelist_email|
    whitelist_email.role = entry[:role]
  end
end
