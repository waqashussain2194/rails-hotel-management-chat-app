class CheckIn < ApplicationRecord
  belongs_to :guest
  belongs_to :hotel
end
