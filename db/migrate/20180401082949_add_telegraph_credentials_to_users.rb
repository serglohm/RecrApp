class AddTelegraphCredentialsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :short_name, :string
    add_column :users, :author_name, :string
    add_column :users, :author_url, :string
    add_column :users, :auth_url, :string
    add_column :users, :access_token, :string
  end
end
