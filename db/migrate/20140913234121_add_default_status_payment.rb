class AddDefaultStatusPayment < ActiveRecord::Migration
  def change
    change_column :payments, :status, :boolean, default: false
  end
end
