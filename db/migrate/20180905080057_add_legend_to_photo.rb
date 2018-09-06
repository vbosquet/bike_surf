class AddLegendToPhoto < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :legend, :string
  end
end
