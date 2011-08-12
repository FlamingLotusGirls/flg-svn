class CreatePooferSequences < ActiveRecord::Migration
  def self.up
    create_table :poofer_sequences do |t|
      t.integer :poofer_id
      t.integer :sequence_id

      t.timestamps
    end
  end

  def self.down
    drop_table :poofer_sequences
  end
end
