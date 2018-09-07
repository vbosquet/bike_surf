class Booking < ApplicationRecord

  belongs_to :user
  belongs_to :listing

  has_many :messages, dependent: :destroy
  accepts_nested_attributes_for :messages
  has_many :booking_statuses, dependent: :destroy
  accepts_nested_attributes_for :booking_statuses

  scope :upcoming, -> { where('start_date >= ?', Time.zone.now.beginning_of_day) }
  scope :past, -> { where('end_date <= ?', Time.zone.now.end_of_day) }
  scope :current, -> { where('start_date <= ? and end_date >= ?', Time.zone.now.beginning_of_day, Time.zone.now.end_of_day) }

  validates :start_date, :end_date, presence: true
  validate :start_date_is_before_end_date

  strip_attributes

  def start_date_is_before_end_date
    return if end_date.blank? || start_date.blank?
    if start_date > end_date
      errors.add(:base, "Le jour d'arrivée ne peut être postérieur au jour de départ.")
    end
  end

  def self.dates
    all_dates = []
    all.each do |booking|
      dates = (booking.start_date.to_date..booking.end_date.to_date).to_a
      all_dates.concat(dates)
    end
    return all_dates.sort
  end

  def self.days(start_date, end_date)
    disabled_dates = all.dates.select { |d| d >= start_date && d <= end_date}.uniq
    days = time_difference(start_date, end_date) - disabled_dates.size
    return days
  end

  private

  def self.time_difference(start_date, end_date)
    dates = (start_date.to_date..end_date.to_date).to_a
    return dates.size
  end

end
