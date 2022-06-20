class User < ApplicationRecord
    has_many :book_rental
    has_many :book, :through => :book_rental
end
