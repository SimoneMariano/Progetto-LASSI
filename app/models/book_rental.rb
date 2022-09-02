class BookRental < ApplicationRecord
    belongs_to :user
    belongs_to :book

   validates :endDate, presence: true
   validates :user_id, uniqueness: { scope: :book_id,
    message: "User can't rent the same book several times at the same time" }
   validate :compare_date

   private def compare_date
        errors.add(:end_date, "must be greater then start date") if 
            self.endDate.present? && self.endDate <= Date.today 
        errors.add(:end_date, "cannot exceed the limit of 3 months (90 days)") if
        self.endDate.present? && (self.endDate - Date.today).to_i  > 90
   end
end
