class CreateCoupons < ActiveRecord::Migration
  def up
    create_table :coupons do |t|
      t.integer :login_id
      t.integer :type
      t.string :name
      t.integer :amount

      t.timestamps
    end
  end

  def down
    drop_table :coupons
  end
end
