class AddCityToCandidates < ActiveRecord::Migration[5.1]
  def change
    add_column :candidates, :city, :string
  end
end
