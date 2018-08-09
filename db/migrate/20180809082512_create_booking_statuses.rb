class CreateBookingStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :booking_statuses do |t|
      t.integer :status, default: 0
      t.integer :booking_id

      t.timestamps
    end
  end
end
