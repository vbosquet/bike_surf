class RemoveActiveFromBike < ActiveRecord::Migration[5.0]
  def change
  	remove_column :bikes, :active
  end
end
