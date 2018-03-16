class AddSourceRefToCandidates < ActiveRecord::Migration[5.1]
  def change
    remove_column :candidates, :source, :string
    add_reference :candidates, :source, foreign_key: true
  end
end
