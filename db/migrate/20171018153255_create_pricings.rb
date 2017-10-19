class CreatePricings < ActiveRecord::Migration[5.0]
  def change
    create_table :pricings do |t|
      t.integer :base_price
      t.integer :average_weekly
      t.integer :average_monthly
      t.string :currency
      t.integer :weekend_pricing
      t.integer :security_deposit
      t.integer :maintenance_fee
      t.integer :listing_id

      t.timestamps
    end
  end
end
