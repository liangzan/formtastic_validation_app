@delivered
Feature: Validate confirmation
In order to minimise the pain of filling forms incorrectly
Forms should validate input as fields are filled
Formtastic validation should be able to validate confirmation

  Scenario: Successful validation of valid fields
    Given I am at the new user form
    When I fill in "12345" for "user_password"
    And I wait for the AJAX call to finish
    Then I should see "Thankyou!" validation message for "user_password"
    When I fill in "12345" for "user_password_confirmation"
    And I wait for the AJAX call to finish
    Then I should see "Thankyou!" validation message for "user_password_confirmation"

  Scenario: Successful validation of invalid fields
    Given I am at the new user form
    When I fill in "12345" for "user_password"
    And I wait for the AJAX call to finish
    Then I should see "Thankyou!" validation message for "user_password"
    When I fill in "123456" for "user_password_confirmation"
    And I wait for the AJAX call to finish
    Then I should see "Does not match!" validation message for "user_password_confirmation"



