class RemoveIndexForBankAccount < ActiveRecord::Migration
  def change
    remove_index :logins, :number_account
  end
end
