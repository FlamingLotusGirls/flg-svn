class AddFiringToPooferSequences < ActiveRecord::Migration
  def self.up
    add_column :poofer_sequences, :firing, :boolean
  end

  def self.down
    remove_column :poofer_sequences, :firing
  end
end
