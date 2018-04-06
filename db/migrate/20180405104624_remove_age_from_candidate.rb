class RemoveAgeFromCandidate < ActiveRecord::Migration[5.1]
  def change
    remove_column :candidates, :age, :integer
  end
end
