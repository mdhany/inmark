class ModifyTurnsTable < ActiveRecord::Migration
  def up
    change_table :turns do |t|
      t.change :status, :string
    end

  end

  def down
    change_table :turns do |t|
      t.change :status, :text
    end

  end
end
