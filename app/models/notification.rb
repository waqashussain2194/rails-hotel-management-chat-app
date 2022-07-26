class Notification < ApplicationRecord
  belongs_to :guest
  belongs_to :hotel
  belongs_to :user, optional: true
end
