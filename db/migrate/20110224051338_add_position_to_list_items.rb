class AddPositionToListItems < ActiveRecord::Migration
  def self.up
    add_column :list_items, :position, :integer
  end

  def self.down
    remove_column :list_items, :position
  end
end