class User < ApplicationRecord
    has_many :book_rental
    has_many :book, :through => :book_rental

    has_one :seat, :through => :reservation
    has_one :reservation, dependent: :destroy
end
