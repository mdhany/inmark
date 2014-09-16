class AddActivatedToLogin < ActiveRecord::Migration
  def up
    add_column :logins, :activated, :boolean, default: false
  end

  def down
    remove_column :logins, :activated
  end
end
