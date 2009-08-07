class CreateIssues < ActiveRecord::Migration
  def self.up
    create_table :issues do |t|
      t.string :contributor_name
      t.string :email
      t.integer :lighthouse_id
      t.text :details
      t.boolean :fixed, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :issues
  end
end
