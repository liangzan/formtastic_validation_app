@delivered
Feature: Validate inclusion
In order to minimise the pain of filling forms incorrectly
Forms should validate input as fields are filled
Formtastic validation should be able to validate inclusion

  Scenario: Successful validation of valid fields
    Given I am at the new user form
    When I fill in "male" for "user_gender"
    And I wait for the AJAX call to finish
    Then I should see "Thank you!" validation message for "user_gender"

  Scenario: Successful validation of invalid fields
    Given I am at the new user form
    And I fill in "cafe" for "user_gender"
    And I wait for the AJAX call to finish
    Then I should see "Must be included in the list!" validation message for "user_gender"



