class AddPolyToLanguages < ActiveRecord::Migration[5.1]
  def change
    add_column :languages, :assignable_id, :integer
    add_column :languages, :assignable_type, :string
    add_index :languages, [:assignable_type, :assignable_id]
  end
end
