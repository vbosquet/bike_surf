class CreateAvailabilities < ActiveRecord::Migration[5.0]
  def change
    create_table :availabilities do |t|
      t.integer :advance_notice
      t.string :maximum_advance_notice_time
      t.integer :minimum_rental
      t.integer :maximum_rental
      t.string :dropoff_time
      t.string :pickup_time
      t.integer :listing_id

      t.timestamps
    end
  end
end
