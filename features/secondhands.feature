Feature: Some secondhands feature

US: As student, I want add, edit, show or remove secondhand, so I can contact or be contacted by other students
US: As a administrator, I want delete or approve a secondhand, so I can make visible a secondhand or remove a secondhand not conform to context 

Scenario: I am logged in as student and I want to create secondhand
Given I am logged in as student
And the presence of existing "Authors"
And the presence of existing "Courses of study"
And the presence of existing "Categories"
And the presence of existing "Books"
And I am on the secondhands page
When I follow "New secondhand adv"
Then I should be on the new secondhand page
When I fill in "Isbn" with "9788808420206"
And I attach the file "db/seeds/fisica_1.jpg" to "Image"
And I fill in "Description" with "Contattatemi in privato per l'acquisto del libro"
And I press "commit"
Then I should see "Secondhand was successfully created."

Scenario: I am logged in as student and I want create a secondhand for a book that I have already used
Given I am logged in as student
And the presence of existing "Authors"
And the presence of existing "Courses of study"
And the presence of existing "Categories"
And the presence of existing "Books"
And an existing secondhand with ISBN 9788808420206
And I am on the new secondhand page
When I fill in "Isbn" with "9788808420206"
And I attach the file "db/seeds/fisica_1.jpg" to "Image"
And I fill in "Description" with "Contattatemi in privato per l'acquisto del libro"
And I press "commit"
Then I should see "can't add secondhand for the same book several times at the same time"

Scenario: I am logged in as student and I want edit secondhand
Given I am logged in as student
And the presence of existing "Authors"
And the presence of existing "Courses of study"
And the presence of existing "Categories"
And the presence of existing "Books"
And an existing secondhand with id: 1 on book with id:1
And I am on the show secondhand with id: 1 page
When I follow "Edit this secondhand"
Then I should be on the edit secondhand with id: 1 page
When I fill in "Description" with "This secondhand has been edited"
And I press "commit"
Then I should see "Secondhand was successfully updated, wait for new approvation."

Scenario: I am logged in as student and I want delete my secondhand
Given I am logged in as student
And the presence of existing "Authors"
And the presence of existing "Courses of study"
And the presence of existing "Categories"
And the presence of existing "Books"
And an existing secondhand with id: 1 on book with id:1
And I am on the show secondhand with id: 1 page
When I press "Delete secondhand"
Then I should see "Secondhand was successfully destroyed."

Scenario: I am logged in as administrator and I want delete my secondhand
Given I am logged in as administrator
And the presence of existing "Authors"
And the presence of existing "Courses of study"
And the presence of existing "Categories"
And the presence of existing "Books"
And an existing secondhand with id: 1 on book with id:1
And I am on the show secondhand with id: 1 page
When I press "Delete secondhand"
Then I should see "Secondhand was successfully destroyed."

Scenario: I am logged in as administrator and I want approve my secondhand
Given I am logged in as administrator
And the presence of existing "Authors"
And the presence of existing "Courses of study"
And the presence of existing "Categories"
And the presence of existing "Books"
And an existing secondhand with id: 1 on book with id:1
And I am on the show secondhand with id: 1 page
When I follow "Approve"
Then I should see "Secondhand was successfully approved."

Scenario: I am logged in as student and I want see secondhand (secondhand approved)
Given I am logged in as student
And the presence of existing "Authors"
And the presence of existing "Courses of study"
And the presence of existing "Categories"
And the presence of existing "Books"
And an existing and approved secondhand with title: Lezioni di fisica. Con e-book. Vol. 1: Meccanica, termodinamica.
And I am on the secondhands page
Then I should see "Lezioni di fisica. Con e-book. Vol. 1: Meccanica, termodinamica."

Scenario: I am logged in as student and I want see secondhand (secondhand not approved)
Given I am logged in as student
And the presence of existing "Authors"
And the presence of existing "Courses of study"
And the presence of existing "Categories"
And the presence of existing "Books"
And an existing and not approved secondhand with title: Lezioni di fisica. Con e-book. Vol. 1: Meccanica, termodinamica.
And I am on the secondhands page
Then I should not see "Lezioni di fisica. Con e-book. Vol. 1: Meccanica, termodinamica."




