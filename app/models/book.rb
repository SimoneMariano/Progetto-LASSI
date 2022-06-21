class Book < ApplicationRecord
    has_many :BookRental
    has_many :user, :through => :book_rental
end
