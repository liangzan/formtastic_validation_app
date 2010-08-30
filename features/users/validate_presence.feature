@delivered
Feature: Validate presence
In order to minimise the pain of filling forms incorrectly
Forms should validate input as fields are filled
Formtastic validation should be able to validate presence

  Scenario: Successful validation of valid fields
    Given I am at the new user form
    When I fill in "Kilgore Trout" for "user_name"
    And I wait for the AJAX call to finish
    Then I should see "Thankyou!" validation message for "user_name"

  Scenario: Successful validation of invalid fields
    Given I am at the new user form
    And I fill in "" for "user_name"
    And I wait for the AJAX call to finish
    And I press "add"
    Then I should see "you must have a name" validation message for "user_name"



