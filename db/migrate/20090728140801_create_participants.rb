class CreateParticipants < ActiveRecord::Migration
  def self.up
    create_table :participants do |t|
      t.string :name,  :null => false
      t.string :location
      t.string :lighthouse_id
      t.string :github_id
      t.integer :score, :default => 0
      t.boolean :active, :default => true

      t.timestamps
    end

    add_index :participants, [:name, :lighthouse_id]
    add_index :participants, :active
  end

  def self.down
    remove_index :participants, :active
    remove_index :participants, [:name, :lighthouse_id]
    drop_table :participants
  end
end
