class AddResumeToCandidates < ActiveRecord::Migration[5.1]
  def change
    add_column :candidates, :resume, :string
  end
end
