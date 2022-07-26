class Hotel < ApplicationRecord
  has_many :check_ins, dependent: :restrict_with_error
  has_many :guests, through: :check_ins
  has_many :messages, dependent: :restrict_with_error
  has_many :notifications, dependent: :restrict_with_error
  has_many :users, dependent: :restrict_with_error

  validates :external_id, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :phone, presence: true, uniqueness: { case_sensitive: false }
end
