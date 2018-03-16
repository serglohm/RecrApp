class ChangeStatusTypeToCandidates < ActiveRecord::Migration[5.1]
  def change
    change_column :candidates, :status, 'integer USING CAST(status AS integer)'
  end
end
