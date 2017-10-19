class RemoveLocationIdFromListing < ActiveRecord::Migration[5.0]
  def change
    remove_column :listings, :location_id, :integer
  end
end
