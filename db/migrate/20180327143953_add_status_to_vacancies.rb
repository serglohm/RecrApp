class AddStatusToVacancies < ActiveRecord::Migration[5.1]
  def change
    add_column :vacancies, :closed, :boolean
  end
end
