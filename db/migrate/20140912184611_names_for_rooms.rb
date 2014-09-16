class NamesForRooms < ActiveRecord::Migration
  def up
    add_column :rooms, :one_n, :string
    add_column :rooms, :two_n, :string
    add_column :rooms, :three_n, :string
    add_column :rooms, :four_n, :string
    add_column :rooms, :five_n, :string
    add_column :rooms, :six_n, :string
    add_column :rooms, :seven_n, :string
  end

  def down
    remove_column :rooms, :one_n
    remove_column :rooms, :two_n
    remove_column :rooms, :three_n
    remove_column :rooms, :four_n
    remove_column :rooms, :five_n
    remove_column :rooms, :six_n
    remove_column :rooms, :seven_n
  end
end
