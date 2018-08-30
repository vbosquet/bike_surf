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
		monthly_price = self.base_price * 28
		monthly_discount = monthly_price * (self.monthly_discount / 100)
		return monthly_price - monthly_discount
	end

	def average_weekly
		weekly_price = self.base_price * 7
		weekly_discount = weekly_price * (self.weekly_discount / 100)
		return weekly_price - weekly_discount
	end
end
