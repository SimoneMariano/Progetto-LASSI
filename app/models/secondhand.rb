class Secondhand < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :book

  #validate request of secondhand
  validate :book_exists
  validates :image, presence:  {message: "An image is necessary to verify the book's state of conservation "}
  validates :user_id, uniqueness: { scope: :book_id,
    message: "can't add secondhand for the same book several times at the same time" }
  
  

  

  private def book_exists
    errors.add(:book_id, "must be present on catalog, please ask the admin to add it") if self.book_id.blank?
  end
end
