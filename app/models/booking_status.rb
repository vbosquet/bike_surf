class BookingStatus < ApplicationRecord
  belongs_to :booking, optional: true

  enum status: [:pending, :accepted, :refused, :canceled]

end
