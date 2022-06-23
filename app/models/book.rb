class Book < ApplicationRecord
    has_many :book_rental
    has_many :secondhand
    has_many :sec
    has_many :user, :through => :book_rental
    has_many :user, :through => :secondhand
end
