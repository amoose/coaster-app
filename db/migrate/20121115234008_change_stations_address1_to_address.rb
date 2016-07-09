class ChangeStationsAddress1ToAddress < ActiveRecord::Migration
  def up
    remove_column :stations, :address1
    add_column :stations, :address, :string
  end

  def down
  end
end
