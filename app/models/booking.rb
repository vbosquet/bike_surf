class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  has_one :message, dependent: :destroy
  accepts_nested_attributes_for :message

  scope :upcoming, -> { where('start_date >= ?', Time.zone.now.beginning_of_day) }
  scope :past, -> { where('end_date <= ?', Time.zone.now.end_of_day) }
  scope :current, -> { where('start_date <= ? and end_date >= ?', Time.zone.now.beginning_of_day, Time.zone.now.end_of_day) }

  validates :start_date, :end_date, presence: true
  validate :start_date_is_before_end_date

  enum status: [:pending, :accepted, :refused, :canceled]

  def start_date_is_before_end_date
    return if end_date.blank? || start_date.blank?
    if start_date > end_date
      errors.add(:base, "Le jour d'arrivée ne peut être postérieur au jour de départ.")
    end
  end

  def self.disabled_dates
    disabled_dates = []
    all.each do |booking|
      dates = (booking.start_date.to_date..booking.end_date.to_date).to_a
      disabled_dates.concat(dates)
    end
    return disabled_dates.sort
  end

end
