class AddIndexToDesination < ActiveRecord::Migration
  def change
  	add_index :destinations, :user_id
  end
end
