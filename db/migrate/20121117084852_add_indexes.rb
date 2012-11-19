class AddIndexes < ActiveRecord::Migration
  def up
  	add_index :trains, :station_id
  end

  def down
  	remove_index :trains, :station_id
  end
end
