class CreateGrablists < ActiveRecord::Migration
  def self.up
    create_table :grablists do |t|
      t.string :feedurl
      t.string :title
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :grablists
  end
end
