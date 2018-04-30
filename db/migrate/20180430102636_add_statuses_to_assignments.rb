class AddStatusesToAssignments < ActiveRecord::Migration[5.1]
  def change
    add_column :assignments, :finish_date, :date
    add_column :assignments, :rejected, :boolean
    add_column :assignments, :reject_reason, :string
    add_column :assignments, :withdrawn, :boolean
    add_column :assignments, :withdrawn_reason, :string
    add_column :assignments, :hired, :boolean
    add_column :assignments, :salary, :integer
  end
end
