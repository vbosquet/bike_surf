class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  scope :upcoming, -> { where('start_date > ?', Time.zone.now.beginning_of_day) }
  scope :past, -> { where('end_date < ?', Time.zone.now.end_of_day) }

  validates :start_date, :end_date, presence: true
end
