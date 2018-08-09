class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  
  strip_attributes
end
