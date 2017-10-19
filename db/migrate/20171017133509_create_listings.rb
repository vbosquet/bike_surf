class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.boolean :listed, default: false
      t.integer :user_id
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
