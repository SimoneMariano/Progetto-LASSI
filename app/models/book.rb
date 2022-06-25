class Book < ApplicationRecord
    has_many :book_rental
    has_many :secondhand, dependent: :destroy 
    has_and_belongs_to_many :category, dependent: :destroy
    has_and_belongs_to_many :author, dependent: :destroy
    has_many :user, :through => :book_rental
    has_many :user, :through => :secondhand
    has_one_attached :placeholder
end
