class Listing < ApplicationRecord
	belongs_to :user
	has_one :location, dependent: :destroy
	accepts_nested_attributes_for :location
	has_one :bike, dependent: :destroy
	accepts_nested_attributes_for :bike
	has_one :pricing, dependent: :destroy
	has_one :availability, dependent: :destroy
	has_many :bookings

	validates :title, :description, presence: true

end
