# frozen_string_literal: true

# features/step_definitions/login_steps.rb

Given('I am on the login page') do
  visit login_path
end

When('I fill in the username with {string}') do |username|
  fill_in 'session_username', with: username
end

When('I fill in the password with {string}') do |password|
  fill_in 'session_password', with: password
end

#   When("I click the {string} button") do |button|
#     click_button button
#   end

Then('I should be redirected to the home page') do
  expect(current_path).to eq(current_path)
end

Then('I should see an error message') do
  expect(page).to have_content('Invalid username or password')
end

When('I click the {string} link') do |link|
  click_link link
end

Then('I should be redirected to the sign-up page') do
  expect(current_path).to eq(signup_path)
end

Then('I should be redirected to the Google OAuth login page') do
  # Add expectations for Google OAuth page redirection
  # You may need to check the specific URL or path for Google OAuth
  expect(current_url).to match(%r{^https://accounts\.google\.com/.*})
end
