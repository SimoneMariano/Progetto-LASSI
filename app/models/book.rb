class Book < ApplicationRecord
    has_many :book_rental
    has_many :secondhand, dependent: :destroy 
    has_and_belongs_to_many :category, dependent: :destroy
    has_and_belongs_to_many :course, dependent: :destroy
    has_and_belongs_to_many :author, dependent: :destroy
    has_many :user, :through => :book_rental
    has_many :user, :through => :secondhand
    has_one_attached :placeholder


    #validation
    validates :ISBN, presence: true, length: {is: 13}
    validates :title, presence: true
    validates :placeholder, presence: true
    validates :stock, presence: true
    
    validate :author_presence
    validate :course_presence
    validate :category_presence
    


    private def author_presence 
        errors.add(:author, "can't be blank") if self.author.blank?
    end

    private def category_presence 
        errors.add(:category, "can't be blank") if self.category.blank?
    end

    private def course_presence 
        errors.add(:course, "can't be blank") if self.course.blank?
    end
    

    
    

end
