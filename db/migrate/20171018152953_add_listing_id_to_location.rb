class AddListingIdToLocation < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :listing_id, :integer
  end
end
