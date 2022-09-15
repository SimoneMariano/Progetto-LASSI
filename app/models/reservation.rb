class Reservation < ApplicationRecord

    belongs_to :user
    belongs_to :seat

    validates :startDate, presence: true
    validates :endDate, presence: true
    validates :user_id, uniqueness: { scope: :date,
     message: "User can't rent the same seat several times at the same time" }
    validate :compare_date
 
    private def compare_date
        errors.add(:endDate, "must be greater then start date") if 
            self.endDate.present? && self.endDate <= self.startDate
        errors.add(:endDate, "cannot exceed the limit of a day") if
            self.endDate.present? && (self.endDate.to_date - self.startDate.to_date).to_i  > 0
    end

end
