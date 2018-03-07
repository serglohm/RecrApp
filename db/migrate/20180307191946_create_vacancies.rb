class CreateVacancies < ActiveRecord::Migration[5.1]
  def change
    create_table :vacancies do |t|
      t.string :name
      t.string :telegraph_link_ru
      t.string :telegraph_link_en
      t.text :description
      t.integer :salary_min
      t.integer :salary_max

      t.timestamps
    end
  end
end
