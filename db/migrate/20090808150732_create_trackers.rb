class CreateTrackers < ActiveRecord::Migration
  def self.up
    create_table :trackers do |t|
      t.integer :ticket_id
      t.text :saved_entry

      t.timestamps
    end
  end

  def self.down
    drop_table :trackers
  end
end
