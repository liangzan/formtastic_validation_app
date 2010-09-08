@delivered
Feature: Validate numericality
In order to minimise the pain of filling forms incorrectly
Forms should validate input as fields are filled
Formtastic validation should be able to validate numericality

  Scenario: Successful validation of valid fields
    Given I am at the new user form
    When I fill in "12345678" for "user_mobile"
    And I wait for the AJAX call to finish
    Then I should see "Thank you!" validation message for "user_mobile"

  Scenario: Successful validation of invalid fields
    Given I am at the new user form
    And I fill in "abcdefg" for "user_mobile"
    And I wait for the AJAX call to finish
    Then I should see "Must be a number!" validation message for "user_mobile"



