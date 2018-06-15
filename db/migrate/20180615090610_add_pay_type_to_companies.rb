class AddPayTypeToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :pay_type, :integer, default: 0
  end
end
