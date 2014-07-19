class AddEmailAuthenticateToUser < ActiveRecord::Migration
  def change
    add_column :users, :email_authen, :boolean
  end
end
