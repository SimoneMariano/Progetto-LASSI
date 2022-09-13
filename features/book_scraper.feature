Feature: Book scraper feature

US: As student, i want buy book, so i can keep a book without having to return it

Scenario: I am logged in as user and I want buy the existing book with isbn: 9788808420206
Given I am logged in as student
And the presence of existing "Authors"
And the presence of existing "Courses of study"
And the presence of existing "Categories"
And the presence of existing "Books"
And I am on the books page
When I follow "scraper-9788808420206"
Then I should be on the buy book with isbn: 9788808420206 page