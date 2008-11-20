class AddLocationToLocation < ActiveRecord::Migration
  def self.up
    add_column :locations, :location, :string
  end

  def self.down
    remove_column :locations, :location
  end
end
