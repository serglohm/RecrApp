class AddLastSentToChatMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :chat_messages, :last_sent, :datetime
  end
end
