class AddLanguagesToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :languages, :text
  end
end
