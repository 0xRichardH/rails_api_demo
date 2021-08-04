class User < ApplicationRecord
  has_many :posts
  has_many :comments

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
end
