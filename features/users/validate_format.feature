@delivered
Feature: Validate format
In order to minimise the pain of filling forms incorrectly
Forms should validate input as fields are filled
Formtastic validation should be able to validate format

  Scenario: Successful validation of valid fields
    Given I am at the new user form
    When I fill in "me@email.com" for "user_email"
    And I wait for the AJAX call to finish
    Then I should see "Thankyou!" validation message for "user_email"

  Scenario: Successful validation of invalid fields
    Given I am at the new user form
    And I fill in "me" for "user_email"
    And I wait for the AJAX call to finish
    And I press "add"
    Then I should see "Not valid!" validation message for "user_email"



