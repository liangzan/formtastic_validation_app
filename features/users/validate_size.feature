@delivered
Feature: Validate size
In order to minimise the pain of filling forms incorrectly
Forms should validate input as fields are filled
Formtastic validation should be able to validate size

  Scenario: Successful validation of valid fields
    Given I am at the new user form
    When I fill in "12345" for "user_company"
    And I wait for the AJAX call to finish
    Then I should see "Thankyou!" validation message for "user_company"

  Scenario: Successful validation of invalid fields
    Given I am at the new user form
    And I fill in "1234" for "user_company"
    And I wait for the AJAX call to finish
    Then I should see "Must be 5 characters long!" validation message for "user_company"



