class CreatingRooms < ActiveRecord::Migration
  def up
    create_table :rooms do |r|
      r.integer :level_id, default: 1
      r.boolean :status, default: true
      r.integer :one
      r.integer :two
      r.integer :three
      r.integer :four
      r.integer :five
      r.integer :six
      r.integer :seven

      r.timestamps
    end
  end

  def down
    drop_table :rooms
  end
end