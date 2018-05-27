class AddApiIdAndApiHashAndPhoneNumberToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :telegram_api_id, :integer
    add_column :users, :telegram_api_hash, :string
    add_column :users, :phone_number, :string
  end
end
