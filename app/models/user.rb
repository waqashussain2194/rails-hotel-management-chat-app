class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  belongs_to :hotel

  has_many :messages, dependent: :restrict_with_error
  has_many :notifications, dependent: :restrict_with_error
end
