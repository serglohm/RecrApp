class AddJobLinkToVacancies < ActiveRecord::Migration[5.1]
  def change
    add_column :vacancies, :job_link, :string
    add_column :vacancies, :telegram_desc_ru, :text
    add_column :vacancies, :telegram_desc_en, :text
  end
end
