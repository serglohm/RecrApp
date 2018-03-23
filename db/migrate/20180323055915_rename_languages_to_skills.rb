class RenameLanguagesToSkills < ActiveRecord::Migration[5.1]
  def change
    rename_column :candidates, :skills, :description
    rename_table :lang_requirements, :skill_requirements
    rename_table :lang_skills, :skill_abilities
    rename_table :languages, :skills
    rename_column :skill_requirements, :language_id, :skill_id
    rename_column :skill_abilities, :language_id, :skill_id
  end
end
