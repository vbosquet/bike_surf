class AddChildSeatEquipmentToBike < ActiveRecord::Migration[5.0]
  def change
    add_column :bikes, :child_seat, :boolean, default: false
  end
end
