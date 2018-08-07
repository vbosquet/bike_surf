class ChangeColumnNamesInConversation < ActiveRecord::Migration[5.0]
  def change
    rename_column :conversations, :sender_id, :borrower_id
    rename_column :conversations, :recever_id, :lender_id
  end
end
