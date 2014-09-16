class AddNextPositionForRoom < ActiveRecord::Migration
  def change
    add_column :rooms, :left_nextp, :integer, default: 4
    add_column :rooms, :right_nextp, :integer, default: 6
  end
end
