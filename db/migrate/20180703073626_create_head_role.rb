class CreateHeadRole < ActiveRecord::Migration[5.1]
  def change
    Role.create(name: :head)
  end
end
