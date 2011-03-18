class AddPublicPrivateFlagToList < ActiveRecord::Migration
  def self.up
    add_column :lists, :public, :boolean, :default => true
  end

  def self.down
    remove_column :lists, :public
  end
end