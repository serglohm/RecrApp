class AddSourceToCandidates < ActiveRecord::Migration[5.1]
  def change
    add_column :candidates, :source, :string
  end
end
