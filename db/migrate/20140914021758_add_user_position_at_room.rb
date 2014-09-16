class AddUserPositionAtRoom < ActiveRecord::Migration
  def up
    add_column :logins, :position, :integer
  end

  def down
    remove_column :logins, :position
  end
end
