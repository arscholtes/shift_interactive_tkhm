class User < ApplicationRecord
  has_one :address

  validates :name, :email, :phone, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
