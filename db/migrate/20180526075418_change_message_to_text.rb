class ChangeMessageToText < ActiveRecord::Migration[5.1]
  def change
    change_column :chat_messages, :message, :text
  end
end
