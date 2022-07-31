class BookRental < ApplicationRecord
    belongs_to :user
    belongs_to :book

   validates :endDate, presence: true
   validate :compare_date

   private def compare_date
        errors.add(:end_date, "must be greater then start date") if 
            self.endDate.present? && self.endDate <= Date.today 
   end
end
