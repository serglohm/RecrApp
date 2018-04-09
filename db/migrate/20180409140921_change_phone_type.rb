class ChangePhoneType < ActiveRecord::Migration[5.1]
  def change
    change_column :candidates, :phone, :string
  end
end
