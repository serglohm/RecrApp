class AddPayTypeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :pay_type, :integer, default: 0
    add_column :users, :rate_per_candidate, :integer, default: 0
    add_column :users, :base_salary, :integer, default: 0
    add_column :users, :salary_threshold, :integer, default: 0
    add_column :users, :bonus_salary_rate, :integer, default: 0
  end
end
