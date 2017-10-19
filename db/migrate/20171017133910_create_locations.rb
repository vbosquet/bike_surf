class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :route
      t.integer :street_number
      t.string :locality
      t.integer :postal_code
      t.float :latitude
      t.float :longitude
      t.string :country_code

      t.timestamps
    end
  end
end
