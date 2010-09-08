@delivered
Feature: Validate length
In order to minimise the pain of filling forms incorrectly
Forms should validate input as fields are filled
Formtastic validation should be able to validate length

  Scenario: Successful validation of valid fields
    Given I am at the new user form
    When I fill in "12345" for "user_website"
    And I wait for the AJAX call to finish
    Then I should see "Thank you!" validation message for "user_website"

  Scenario: Successful validation of invalid fields
    Given I am at the new user form
    And I fill in "1234" for "user_website"
    And I wait for the AJAX call to finish
    Then I should see "Must be 5 characters long!" validation message for "user_website"



