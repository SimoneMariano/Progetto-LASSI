class Course < ApplicationRecord
    has_and_belongs_to_many :book, dependent: :destroy
    has_many :user, dependent: :destroy

    validates :name, presence: true, uniqueness: true
end
