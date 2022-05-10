class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true 
  validates :profile_picture, presence: true
  has_many :posts
  




end
