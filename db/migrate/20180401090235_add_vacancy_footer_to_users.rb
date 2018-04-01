class AddVacancyFooterToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :vacancy_footer, :text
  end
end
