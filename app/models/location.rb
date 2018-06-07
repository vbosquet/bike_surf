class Location < ApplicationRecord
	belongs_to :listing, optional: true
	geocoded_by :address
	after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed?}

	validates :route, :postal_code, :locality, :country_code, presence: true
	
	def address
		[self.street_number, self.route, self.postal_code, self.locality, self.country_code].compact.join(', ')
	end

	def address_changed?
		attrs = %w(street_number route postal_code locality country_code)
		attrs.any?{|a| send "#{a}_changed?"}
	end
end
