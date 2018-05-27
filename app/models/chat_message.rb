class ChatMessage < ApplicationRecord
  belongs_to :vacancy
  belongs_to :chat
end
