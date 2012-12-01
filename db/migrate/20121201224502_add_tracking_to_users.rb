class AddTrackingToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :tracking, :boolean, :default => false
  end
end
