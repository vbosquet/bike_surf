class CreateBikes < ActiveRecord::Migration[5.0]
  def change
    create_table :bikes do |t|
      t.integer :size
      t.boolean :lights, default: false
      t.boolean :active, default: false
      t.integer :location_id
      t.integer :listing_id

      t.timestamps
    end
  end
end
