class AddDefaultValuesToMinimumAndMaximumRental < ActiveRecord::Migration[5.0]
  def change
    change_column_default :availabilities, :minimum_rental, 1
    change_column_default :availabilities, :maximum_rental, 1
    change_column_default :availabilities, :advance_notice, 0
    change_column_default :availabilities, :pickup_time, "00:00"
    change_column_default :availabilities, :dropoff_time, "00:00"
  end
end
