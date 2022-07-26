class Guest < ApplicationRecord
  has_many :check_ins, dependent: :restrict_with_error
  has_many :messages, dependent: :restrict_with_error
  has_many :notifications, dependent: :restrict_with_error

  validates :external_id, presence: true, uniqueness: { case_sensitive: false }
end
