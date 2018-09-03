class RemoveMaximumAdvanceNoticeFromAvailibilityTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :availabilities, :maximum_advance_notice_time
  end
end
