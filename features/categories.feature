Feature: Some Categories feature

US: As administrator, i want add, edit, show or remove categories, so i can give details about the books


Scenario: I am logged in as administrator and i want to add categories
Given I am logged in as administrator
And I am on the categories page
When I follow "new-category"
Then I should be on the new category page
When I fill in "Name" with "Daniele Sette"
And press "commit"
Then I should see "Category was successfully created."

Scenario: I am logged in as administrator and i want to edit categories
Given I am logged in as administrator
Given a category with id 1
And I am on the show category with id: 1 page
When I follow "Edit this category"
Then I should be on the edit category with id: 1 page
When I fill in "Name" with "Category edited"
And press "commit"
Then I should see "Category was successfully updated."

Scenario: I am logged in as administrator and i want to delete categories
Given I am logged in as administrator
Given a category with id 1
And I am on the show category with id: 1 page
When I press "Delete category"
Then I should see "Category was successfully destroyed."