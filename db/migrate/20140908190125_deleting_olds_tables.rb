class DeletingOldsTables < ActiveRecord::Migration
  def change
    drop_table :roles
    drop_table :turns
    drop_table :capacities
  end
end
