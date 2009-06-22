class ChangeLongLatsToFloatsInsteadOfDecimals < ActiveRecord::Migration
  def self.up
    change_column :locations, :longitude, :float
    change_column :locations, :latitude, :float
  end

  def self.down
    change_column :locations, :longitude, :decimal
    change_column :locations, :latitude, :decimal
  end
end
