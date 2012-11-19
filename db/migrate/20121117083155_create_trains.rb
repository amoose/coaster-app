class CreateTrains < ActiveRecord::Migration
  def change
    create_table :trains do |t|
      t.string :name
      t.time :departure_time
      t.string :direction
      t.boolean :wifi

      t.timestamps
    end
  end
end
