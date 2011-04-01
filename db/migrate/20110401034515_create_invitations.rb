class CreateInvitations < ActiveRecord::Migration
  def self.up
    create_table :invitations do |t|
      t.integer :list_id
      t.string :role
      t.string :token
      t.string :state, :default => "pending" 
      t.string :email
      t.integer :inviter_id

      t.timestamps
    end
  end

  def self.down
    drop_table :invitations
  end
end
