Feature: User Login

  Scenario: User can log in with valid credentials
    Given I am on the login page
    When I fill in the username with "valid_username"
    And I fill in the password with "valid_password"
    And I click the "Login" button
    Then I should be redirected to the home page

  Scenario: User sees an error message with invalid credentials
    Given I am on the login page
    When I fill in the username with "invalid_username"
    And I fill in the password with "invalid_password"
    And I click the "Login" button
    Then I should see "You are not whitelisted.Contact your administrator"

  Scenario: User can sign up for a new account
    Given I am on the login page
    When I click the "Sign up" link
    Then I should be redirected to the sign-up page


