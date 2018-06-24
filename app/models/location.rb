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

	def country_name
		if country_code.present?
			country = ISO3166::Country.new(country_code)
	    country.translations[I18n.locale.to_s] || country.name
		end
  end

	def address_line_1
		[self.street_number, self.route].compact.join(', ')
	end

	def address_line_2
		[self.postal_code, self.locality].compact.join(', ')
	end

end
