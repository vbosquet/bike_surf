class AddDeadlineToAvailabilityTable < ActiveRecord::Migration[5.0]
  def change
    add_column :availabilities, :deadline, :string, default: "00:00"
  end
end
