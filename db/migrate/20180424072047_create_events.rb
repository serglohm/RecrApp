class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.belongs_to :assignments, foreign_key: true
      t.datetime :scheduled_on
      t.string :name

      t.timestamps
    end
  end
end
