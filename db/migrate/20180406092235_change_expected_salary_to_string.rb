class ChangeExpectedSalaryToString < ActiveRecord::Migration[5.1]
  def change
    change_column :candidates, :expected_salary, :string
  end
end
