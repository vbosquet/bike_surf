class AddInfosToBike < ActiveRecord::Migration[5.0]
  def change
    add_column :bikes, :hasBackPedalBrake, :boolean, default: false
    add_column :bikes, :helmet, :boolean, default: false
    add_column :bikes, :basket, :boolean, default: false
    add_column :bikes, :fonts, :boolean, default: false
  end
end
