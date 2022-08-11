class Seat < ApplicationRecord

    has_one :user, :through => :reservation
    has_one :reservation, dependent: :destroy

end
