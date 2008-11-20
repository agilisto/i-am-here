class AddDescriptionAndShortLinkToLocation < ActiveRecord::Migration
  def self.up
    add_column :locations, :description, :string
    add_column :locations, :link, :string
  end

  def self.down
    remove_column :locations, :link
    remove_column :locations, :description
  end
end
