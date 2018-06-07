class Pricing < ApplicationRecord
	belongs_to :listing

	validates :currency, presence: true

	def self.all_currencies
		currencies = []
		Money::Currency.table.values.each do |currency|
			currencies.push([currency[:iso_code], currency[:iso_code]])
		end
		return currencies
	end
end
