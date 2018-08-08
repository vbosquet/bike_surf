class Message < ApplicationRecord
  belongs_to :conversation, optional: true
  belongs_to :booking, optional: true
  belongs_to :user, optional: true
end
