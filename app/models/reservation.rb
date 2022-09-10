class Reservation < ApplicationRecord

    belongs_to :user
    belongs_to :seat

    validates :endDate, presence: true
    validates :user_id, uniqueness: { scope: :seat_id,
     message: "User can't rent the same seat several times at the same time" }
    validate :compare_date
 
    private def compare_date
         errors.add(:end_date, "must be greater then start date") if 
             self.endDate.present? && self.endDate <= Date.today 
    end

end
