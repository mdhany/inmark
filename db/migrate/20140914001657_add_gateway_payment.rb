class AddGatewayPayment < ActiveRecord::Migration
  def change
    add_column :payments, :gateway, :string
  end
end
