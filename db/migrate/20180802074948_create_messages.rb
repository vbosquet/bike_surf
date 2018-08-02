class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :conversation_id
      t.text :body
      t.integer :booking_id

      t.timestamps
    end
  end
end
