class CreateListItems < ActiveRecord::Migration
  def self.up
    create_table :list_items do |t|
      t.string :body
      t.integer :creator_id
      t.integer :list_id
      t.string :state, :default =>"created"

      t.timestamps
    end
  end

  def self.down
    drop_table :list_items
  end
end
