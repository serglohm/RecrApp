class CreateChatMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :chat_messages do |t|
      t.integer :chat_id
      t.integer :vacancy_id
      t.string :message

      t.timestamps
    end
    add_index :chat_messages, [:chat_id, :vacancy_id]
  end
end
