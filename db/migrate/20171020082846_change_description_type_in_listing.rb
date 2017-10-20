class ChangeDescriptionTypeInListing < ActiveRecord::Migration[5.0]
  def change
  	change_column :listings, :description, :text
  end
end
