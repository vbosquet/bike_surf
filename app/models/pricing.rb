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

	def average_monthly
		price = self.base_price * 28
		discount = price * (self.monthly_discount / 100.0)
		average = price - discount
		return average.round
	end

	def average_weekly
		price = self.base_price * 7
		discount = price * (self.weekly_discount / 100.0)
		average = price - discount
		return average.round
	end
end
