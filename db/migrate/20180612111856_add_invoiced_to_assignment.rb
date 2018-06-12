class AddInvoicedToAssignment < ActiveRecord::Migration[5.1]
  def change
    add_column :assignments, :invoiced, :boolean, default: false
  end
end
