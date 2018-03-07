class AddLinksToCandidate < ActiveRecord::Migration[5.1]
  def change
    add_column :candidates, :linked_in, :string
    add_column :candidates, :github, :string
  end
end
