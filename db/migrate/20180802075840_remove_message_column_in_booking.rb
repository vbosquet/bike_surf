class RemoveMessageColumnInBooking < ActiveRecord::Migration[5.0]
  def change
    remove_column :bookings, :message, :text
  end
end
