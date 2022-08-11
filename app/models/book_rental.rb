class BookRental < ApplicationRecord
    belongs_to :user
    belongs_to :book

   validates :endDate, presence: true
   validate :compare_date

   private def compare_date
        errors.add(:end_date, "must be greater then start date") if 
            self.endDate.present? && self.endDate <= Date.today 
        errors.add(:end_date, "cannot exceed the limit of 3 months (90 days)") if
            (book_rental.endDate - Date.today).to_i  > 90
   end
end
