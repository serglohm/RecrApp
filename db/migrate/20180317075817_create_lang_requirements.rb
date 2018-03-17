class CreateLangRequirements < ActiveRecord::Migration[5.1]
  def change
    create_table :lang_requirements do |t|
      t.belongs_to :vacancy, foreign_key: true
      t.belongs_to :language, foreign_key: true

      t.timestamps
    end
  end
end
