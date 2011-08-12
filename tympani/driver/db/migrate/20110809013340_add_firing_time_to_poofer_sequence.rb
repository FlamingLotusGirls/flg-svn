class AddFiringTimeToPooferSequence < ActiveRecord::Migration
  def self.up
    add_column :poofer_sequences, :firing_time, :integer
  end

  def self.down
    remove_column :poofer_sequences, :firing_time
  end
end
