class AddMlmColumnToLogin < ActiveRecord::Migration
  def change
    add_column :logins, :mlm_started, :boolean, default: false
  end
end
