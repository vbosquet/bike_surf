class RemoveAttachementFromBike < ActiveRecord::Migration[5.0]
  def change
    remove_attachment :bikes, :photo  
  end
end
