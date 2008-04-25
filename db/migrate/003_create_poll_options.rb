class CreatePollOptions < ActiveRecord::Migration
  def self.up
    create_table :poll_options do |t|
      t.integer :poll_id
      t.boolean :enable_captcha

      t.timestamps
    end
  end

  def self.down
    drop_table :poll_options
  end
end
