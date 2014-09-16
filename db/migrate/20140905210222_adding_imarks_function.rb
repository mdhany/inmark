class AddingImarksFunction < ActiveRecord::Migration
  def up
    add_column :logins, :room_id, :integer
    add_column :logins, :address, :string
    remove_column :logins, :used
    remove_column :logins, :role_id
  end

  def down
    remove_column :logins, :room_id
    remove_column :logins, :address
  end
end
