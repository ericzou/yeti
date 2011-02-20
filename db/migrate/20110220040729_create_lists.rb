class CreateLists < ActiveRecord::Migration
  def self.up
    create_table :lists do |t|
      t.string :title
      t.integer :creator_id
      t.text :description
      t.string :style, :default => "numbers"
      t.string :state, :default => "created"
      t.timestamps
    end
  end

  def self.down
    drop_table :lists
  end
end
