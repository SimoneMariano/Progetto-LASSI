class Book < ApplicationRecord
    has_many :book_rental
    has_many :secondhand
    has_and_belongs_to_many :category
    has_many :user, :through => :book_rental
    has_many :user, :through => :secondhand
    has_one_attached :placeholder
end
