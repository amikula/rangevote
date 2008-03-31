class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.integer :poll_id
      t.text :ratings
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :votes
  end
end
