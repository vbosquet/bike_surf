class AddLocationIdToListing < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :location_id, :integer
  end
end
