class FixAllColumnsType < ActiveRecord::Migration
  def change
    rename_column :coupons, :type, :type_c
    rename_column :payments, :type, :type_p
  end
end
