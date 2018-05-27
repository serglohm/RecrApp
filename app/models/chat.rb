class Chat < ApplicationRecord
  belongs_to :user
  has_many :chat_messages
  has_many :vacancies, through: :chat_messages
end
