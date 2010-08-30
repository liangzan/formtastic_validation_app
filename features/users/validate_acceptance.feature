@delivered
Feature: Validate acceptance
In order to minimise the pain of filling forms incorrectly
Forms should validate input as fields are filled
Formtastic validation should be able to validate acceptance

  Scenario: Successful validation of valid fields
    Given I am at the new user form
    When I check "user_terms_of_service"
    And I wait for the AJAX call to finish
    Then I should see "Thankyou!" validation message for "user_terms_of_service"

  Scenario: Successful validation of invalid fields
    Given I am at the new user form
    When I check "user_terms_of_service"
    And I uncheck "user_terms_of_service"
    And I wait for the AJAX call to finish
    Then I should see "Must be accepted!" validation message for "user_terms_of_service"
