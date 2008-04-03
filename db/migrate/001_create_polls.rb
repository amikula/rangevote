class CreatePolls < ActiveRecord::Migration
  def self.up
    create_table :polls do |t|
      t.string :name
      t.text :instructions
      t.text :candidates
      t.string :key
      t.string :admin_key

      t.timestamps
    end

    add_index :polls, :key
    add_index :polls, :admin_key
  end

  def self.down
    drop_table :polls
  end
end
