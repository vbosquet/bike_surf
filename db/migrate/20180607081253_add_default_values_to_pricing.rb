class AddDefaultValuesToPricing < ActiveRecord::Migration[5.0]
  def change
    change_column_default :pricings, :base_price, 0
    change_column_default :pricings, :average_weekly, 0
    change_column_default :pricings, :average_monthly, 0
    change_column_default :pricings, :weekend_pricing, 0
    change_column_default :pricings, :security_deposit, 0
    change_column_default :pricings, :maintenance_fee, 0
  end
end
