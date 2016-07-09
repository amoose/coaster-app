class AddColumnsToTrains < ActiveRecord::Migration
  def change
    add_column :trains, :recurring, :boolean, default: false
    add_column :trains, :completed, :boolean, default: false
    add_column :trains, :recurring_value, :text
    add_column :trains, :next_date, :datetime
  end
end
