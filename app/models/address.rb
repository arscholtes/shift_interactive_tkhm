class Address < ApplicationRecord
  belongs_to :user

  validates :street, :city, :zipcode, presence: true
end
