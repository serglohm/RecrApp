class AddPhoneToCandidates < ActiveRecord::Migration[5.1]
  def change
    add_column :candidates, :phone, :bigint
  end
end
