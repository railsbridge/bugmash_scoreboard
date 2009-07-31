class CreateParticipants < ActiveRecord::Migration
  def self.up
    create_table :participants do |t|
      t.string :email, :null => false
      t.string :name,  :null => false
      t.string :location
      t.string :lighthouse_id
      t.string :github_id
      t.integer :score

      t.string :crypted_password,    :null => false
      t.string :password_salt,       :null => false
      t.string :persistence_token,   :null => false
      t.string :single_access_token, :null => false
      t.string :perishable_token,    :null => false

      t.timestamps
    end
    add_index :participants, :email
    add_index :participants, :persistence_token
    add_index :participants, :perishable_token
  end

  def self.down
    remove_index :participants, :email
    remove_index :participants, :persistence_token
    remove_index :participants, :perishable_token
    drop_table :participants
  end
end
