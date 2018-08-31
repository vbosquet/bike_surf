class ChangeDiscountsTypesInPricingTable < ActiveRecord::Migration[5.0]
  def change
    change_column :pricings, :weekly_discount, :integer
    change_column :pricings, :monthly_discount, :integer
  end
end
