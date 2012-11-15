class AddIndecesToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :admin, :boolean, default: false

  	add_index :users, :email, unique: true
  	add_index 	:users, :remember_token
  end
end
