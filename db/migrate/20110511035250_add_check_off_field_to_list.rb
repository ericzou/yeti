class AddCheckOffFieldToList < ActiveRecord::Migration
  def self.up
    add_column :list_items, :checked_off, :boolean, :default => false 
  end

  def self.down
    remove_column :list_items, :checked_off
  end
end