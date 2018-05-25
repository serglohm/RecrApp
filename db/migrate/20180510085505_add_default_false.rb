class AddDefaultFalse < ActiveRecord::Migration[5.1]
  def up
    change_column :assignments, :rejected, :boolean, default: false
    change_column :assignments, :withdrawn, :boolean, default: false
    change_column :assignments, :hired, :boolean, default: false

    Assignment.all.each do |a|
      if a.rejected == nil
        a.rejected = false
      end
      if a.withdrawn == nil
        a.withdrawn = false
      end
      if a.hired == nil
        a.hired = false
      end
      a.save!
    end
  end

  def down
  end
end
