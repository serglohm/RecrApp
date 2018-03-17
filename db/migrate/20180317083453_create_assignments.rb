class CreateAssignments < ActiveRecord::Migration[5.1]
  def change
    create_table :assignments do |t|
      t.belongs_to :candidate, foreign_key: true
      t.belongs_to :vacancy, foreign_key: true
      t.string :status
      t.timestamps
    end
  end
end
