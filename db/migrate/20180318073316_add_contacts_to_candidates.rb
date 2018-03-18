class AddContactsToCandidates < ActiveRecord::Migration[5.1]
  def change
    add_column :candidates, :skype, :string
    add_column :candidates, :email, :string
    add_column :candidates, :availability, :string
    add_column :candidates, :spoken_languages, :text
  end
end
