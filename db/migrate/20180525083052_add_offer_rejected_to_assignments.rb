class AddOfferRejectedToAssignments < ActiveRecord::Migration[5.1]
  def change
    add_column :assignments, :offer_rejected, :boolean, default: false
    add_column :assignments, :offer_rejected_reason, :string
  end
end
