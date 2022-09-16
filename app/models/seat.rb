class Seat < ApplicationRecord

    has_one :user, :through => :reservation
    has_one :reservation, dependent: :destroy

    validates :name, presence: true, uniqueness: true

end
