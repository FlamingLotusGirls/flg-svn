class CreatePoofers < ActiveRecord::Migration
  def self.up
    create_table :poofers do |t|
      t.integer :board
      t.integer :relay

      t.timestamps
    end
  end

  def self.down
    drop_table :poofers
  end
end
