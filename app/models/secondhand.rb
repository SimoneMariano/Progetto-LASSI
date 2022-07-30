class Secondhand < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :book

  #validate request of secondhand
  validates :image, presence:  {message: "An image is necessary to verify the book's state of conservation "}
  
  
  validates :book_id, presence: true

  private def ISBN_presence 
    errors.add(:book_id, "can't be blank") if self.book_id.blank?
  
end
end
