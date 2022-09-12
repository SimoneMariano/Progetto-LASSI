@omniauth_test
Feature: Some books feature

US: As administrator, i want add, edit, show or remove books, so i can keep the catalogue up to date


Scenario: I am not logged in and I want visit books
Given I am not logged in 
Given I am on the BiblioCommunity home page
When I follow "library"
Then I should be on the log in page
Then I should see "You need to sign in or sign up before continuing."

Scenario: I am logged in and I want visit books
Given I am logged in as administrator
Given I am on the books page
Then I should see "Add book to catalog"

