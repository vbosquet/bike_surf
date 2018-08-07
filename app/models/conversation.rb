class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  paginates_per 10
end
