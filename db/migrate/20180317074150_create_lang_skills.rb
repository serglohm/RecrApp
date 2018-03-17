class CreateLangSkills < ActiveRecord::Migration[5.1]
  def change
    create_table :lang_skills do |t|
      t.belongs_to :candidate, foreign_key: true
      t.belongs_to :language, foreign_key: true

      t.timestamps
    end
  end
end
