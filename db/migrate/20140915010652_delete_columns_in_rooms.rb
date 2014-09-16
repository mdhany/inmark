class DeleteColumnsInRooms < ActiveRecord::Migration
  def change
    remove_column :rooms, :one_n
    remove_column :rooms, :two_n
    remove_column :rooms, :three_n
    remove_column :rooms, :four_n
    remove_column :rooms, :five_n
    remove_column :rooms, :six_n
    remove_column :rooms, :seven_n

    remove_column :rooms, :one
    remove_column :rooms, :two
    remove_column :rooms, :three
    remove_column :rooms, :four
    remove_column :rooms, :five
    remove_column :rooms, :six
    remove_column :rooms, :seven
  end
end
