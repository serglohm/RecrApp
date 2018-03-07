class CreateCandidates < ActiveRecord::Migration[5.1]
  def change
    create_table :candidates do |t|
      t.string :name
      t.integer :age
      t.text :skills
      t.string :status
      t.string :country
      t.string :education
      t.text :experience
      t.integer :expected_salary
      t.string :marital_status
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
