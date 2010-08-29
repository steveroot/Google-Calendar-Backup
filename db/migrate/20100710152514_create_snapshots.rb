class CreateSnapshots < ActiveRecord::Migration
  def self.up
    create_table :snapshots do |t|
      t.string :entryid
      t.string :title
      t.string :summary
      t.text :entryfull
      t.datetime :entryupdated
      t.datetime :entrycreated
      t.string :dedupkey
      t.timestamps
    end
  end

  def self.down
    drop_table :snapshots
  end
end
