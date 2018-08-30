class ChangeColumnNamesInPricingTable < ActiveRecord::Migration[5.0]
  def change
    rename_column :pricings, :average_weekly, :weekly_discount
    rename_column :pricings, :average_monthly, :monthly_discount
  end
end
