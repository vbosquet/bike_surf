class RemoveLocationIdFromBike < ActiveRecord::Migration[5.0]
  def change
    remove_column :bikes, :location_id, :integer
  end
end
