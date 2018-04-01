class AddDescriptionToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :description_ru, :text
    add_column :companies, :description_en, :text
  end
end
