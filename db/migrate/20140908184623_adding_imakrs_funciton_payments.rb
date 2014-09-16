class AddingImakrsFuncitonPayments < ActiveRecord::Migration
  def up
    remove_column :payments, :sent
    remove_column :payments, :received
    remove_column :payments, :turn_id
    remove_column :payments, :beneficiary_id
    remove_column :payments, :gateway
    add_column :payments, :type, :integer, limit: 4
    add_column :payments, :coupon_id, :integer
    add_column :payments, :status, :boolean
  end

  def down
    add_column :payments, :sent, :boolean
    add_column :payments, :received, :boolean
    add_column :payments, :turn_id, :integer
    add_column :payments, :beneficiary_id, :integer
    add_column :payments, :gateway, :string
    remove_column :payments, :type
    remove_column :payments, :coupon_id
    remove_column :payments, :status
  end
end
