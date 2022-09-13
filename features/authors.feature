Feature: Some Authors feature

US: As administrator, i want add, edit, show or remove authors, so i can give details about the books


Scenario: I am logged in as administrator and i want to add authors
Given I am logged in as administrator
And I am on the authors page
When I follow "new-author"
Then I should be on the new author page
When I fill in "Name" with "Daniele Sette"
And press "commit"
Then I should see "Author was successfully created."

Scenario: I am logged in as administrator and i want to edit authors
Given I am logged in as administrator
Given an author with id 1
And I am on the show author with id: 1 page
When I follow "Edit author"
Then I should be on the edit author with id: 1 page
When I fill in "Name" with "Daniele Otto"
And press "commit"
Then I should see "Author was successfully updated."

Scenario: I am logged in as administrator and i want to delete authors
Given I am logged in as administrator
Given an author with id 1
And I am on the show author with id: 1 page
When I press "Delete author"
Then I should see "Author was successfully destroyed."

