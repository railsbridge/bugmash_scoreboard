class CreateActions < ActiveRecord::Migration
  def self.up
    create_table :actions do |t|
      t.belongs_to :participant
      t.integer :lighthouse_id
      t.integer :point_value

      t.timestamps
    end
  end

  def self.down
    drop_table :actions
  end
end
