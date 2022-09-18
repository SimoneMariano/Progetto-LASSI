Feature: Some bulletin board feature

Scenario: As administrator, I want add bulletin to bulletin board, so I can advise student
Given I am logged in as administrator
And I am on the bulletin board page
When I follow "New bulletin"
Then I should be on the new bulletin page
When I fill in "Title" with "New bolletin 1"
And I fill in "Description" with "Some description"
And I press "commit"
Then I should see "Bulletin was successfully created."

Scenario: I am logged in as administrator and i want to edit bulletins
Given I am logged in as administrator
Given a bulletin with id 1
And I am on the show bulletin with id: 1 page
When I follow "Edit this bulletin"
Then I should be on the edit bulletin with id: 1 page
When I fill in "Title" with "Title edited"
When I fill in "Description" with "Description edited"
And press "commit"
Then I should see "Bulletin was successfully updated."

Scenario: I am logged in as administrator and i want to delete bulletins
Given I am logged in as administrator
Given a bulletin with id 1
And I am on the show bulletin with id: 1 page
When I press "Delete bulletin"
Then I should see "Bulletin was successfully destroyed."
