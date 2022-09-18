Feature: Some courses feature

US: As administrator, i want add, edit, show or remove courses, so i can give details about the books


Scenario: I am logged in as administrator and i want to add courses
Given I am logged in as administrator
And I am on the courses page
When I follow "new-course"
Then I should be on the new course page
When I fill in "Name" with "Daniele Sette"
And press "commit"
Then I should see "Course was successfully created."

Scenario: I am logged in as administrator and i want to edit courses
Given I am logged in as administrator
Given a course with id 1
And I am on the show course with id: 1 page
When I follow "Edit course"
Then I should be on the edit course with id: 1 page
When I fill in "Name" with "Course edited"
And press "commit"
Then I should see "Course was successfully updated."

Scenario: I am logged in as administrator and i want to delete courses
Given I am logged in as administrator
Given a course with id 1
And I am on the show course with id: 1 page
When I press "Delete course"
Then I should see "Course was successfully destroyed."