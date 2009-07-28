class CreateParticipants < ActiveRecord::Migration
  def self.up
    create_table :participants do |t|
      t.string :email, :null => false
      t.string :name,  :null => false
      t.string :lighthouse_id
      t.string :github_id
      
      t.string :crypted_password,    :null => false
      t.string :password_salt,       :null => false
      t.string :persistence_token,   :null => false
      t.string :single_access_token, :null => false
      t.string :perishable_token,    :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :participants
  end
end
