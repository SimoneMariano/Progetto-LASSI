class Secondhand < ApplicationRecord
  belongs_to :book
  belongs_to :user
  has_one_attached :image
end
