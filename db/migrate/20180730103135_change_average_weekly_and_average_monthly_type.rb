class ChangeAverageWeeklyAndAverageMonthlyType < ActiveRecord::Migration[5.0]
  def change
    change_column :pricings, :average_weekly, :float
    change_column :pricings, :average_monthly, :float
  end
end
