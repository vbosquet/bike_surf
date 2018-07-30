class Pricing < ApplicationRecord
	has_paper_trail
	
	belongs_to :listing

	validates :currency, :base_price, :average_weekly, :average_monthly, :weekend_pricing,
		:security_deposit, :maintenance_fee, presence: true

	def self.all_currencies
		currencies = []
		Money::Currency.table.values.each do |currency|
			currencies.push([currency[:iso_code], currency[:iso_code]])
		end
		return currencies
	end
end
