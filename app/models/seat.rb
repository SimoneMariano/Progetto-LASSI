class Seat < ApplicationRecord

    has_many :user, :through => :reservation
    has_many :reservation, dependent: :destroy

    validates :name, presence: true, uniqueness: true

end
