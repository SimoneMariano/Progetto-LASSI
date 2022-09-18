Feature: Some books feature

US: As administrator, i want add, edit, show or remove books, so i can keep the catalogue up to date


Scenario: I am not logged in and I want visit books
Given I am not logged in 
And I am on the BiblioCommunity home page
When I follow "library"
Then I should be on the log in page
And I should see "You need to sign in or sign up before continuing."

Scenario: I am logged in as administrator and I want add book to catalog
Given I am logged in as administrator
And the presence of existing "Authors"
And the presence of existing "Courses of study"
And the presence of existing "Categories"
And I am on the books page
When I follow "Add book to catalog"
Then I should be on the new book page
When I fill in "Isbn" with "9788808420206"
And I fill in "Title" with "Lezioni di fisica. Con e-book. Vol. 1: Meccanica, termodinamica."
And I attach the file "db/seeds/fisica_1.jpg" to "Placeholder"
And I fill in "Stock" with "5"
And I select "Daniele Sette" from "authors"
And I select "Mario Bertolotti" from "authors"
And I select "Adriano Alippi" from "authors"
And I select "Ingegneria Informatica e Automatica" from "courses"
And I select "Fisica" from "courses"
And I select "Fisica" from "categories"
And I fill in "Description" with "Libro di Fisica 1"
And I press "commit"
Then I should see "Book was successfully created."

Scenario: I am logged in as student and I want add book to catalog
Given I am logged in as student
And I am on the books page
Then I should not see "Add book to catalog"

Scenario: I am logged in as administrator and I want edit the existing book with id 1 from catalog
Given I am logged in as administrator
And the presence of existing "Authors"
And the presence of existing "Courses of study"
And the presence of existing "Categories"
And the presence of existing "Books"
And I am on the books page
When I follow "book-1"
Then I should be on the show book with id: 1 page
And I should see "Edit this book"
When I follow "Edit this book"
Then I should be on the edit book with id: 1 page
When I fill in "Description" with "This book has been edited"
And I press "commit"
Then I should be on the show book with id: 1 page
And I should see "Book was successfully updated."

Scenario: I am logged in as administrator and I want remove the existing book with id 1 from catalog
Given I am logged in as administrator
And the presence of existing "Authors"
And the presence of existing "Courses of study"
And the presence of existing "Categories"
And the presence of existing "Books"
And I am on the books page
When I follow "book-1"
Then I should be on the show book with id: 1 page
When I press "Remove from catalog"
Then I should be on the library page
And I should see "Book was successfully destroyed."

Scenario: I am logged in as student and I want add to favorite the existing book with id 1 
Given I am logged in as student
And the presence of existing "Authors"
And the presence of existing "Courses of study"
And the presence of existing "Categories"
And the presence of existing "Books"
And I am on the books page
When I follow "book-1"
Then I should be on the show book with id: 1 page
When I follow "favorite-link"
Then I should see "Book was successfully added to favourites."

Scenario: I am logged in as student and I want remove from favorite the existing book with id 1 
Given I am logged in as student
And the presence of existing "Authors"
And the presence of existing "Courses of study"
And the presence of existing "Categories"
And existing book with id: 1 and on the favorite list of user
And I am on the books page
When I follow "book-1"
Then I should be on the show book with id: 1 page
When I follow "favorite-link"
Then I should see "Book was successfully removed from favourites."







 







