Feature: Some profile feature

Scenario: As student, I want see my profile, so I can update or check my details
Given the existing student "user@gmail.com"
And I am logged in as student
And I am on my profile page
Then I should see "My Profile"
And I should see "user@gmail.com"

Scenario: As student, I want edit my profile, so I can update details
Given the existing student "user@gmail.com"
And I am logged in as student
And I am on my profile page
And the presence of existing "Courses of study"
When I follow "Edit profile"
Then I should be on the edit profile page
When I fill in "user_name" with "User"
And I fill in "user_surname" with "Example"
And I attach the file "db/seeds/fisica_1.jpg" to "user_image"
And I fill in "user_matricola" with "1234567891234"
And I select "Ingegneria Informatica e Automatica" from "course_id"
And press "commit"
Then I should see "User was successfully updated."

Scenario: As student, I want remove favorite from my profile page, so I can update details
Given I am logged in as student
And the presence of existing "Authors"
And the presence of existing "Courses of study"
And the presence of existing "Categories"
And existing book with id: 1 and on the favorite list of user
And I am on my profile page
When I follow "remove-favorite-1"
Then I should see "Book was successfully removed from favourites."





