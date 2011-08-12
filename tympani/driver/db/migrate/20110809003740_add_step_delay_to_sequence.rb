class AddStepDelayToSequence < ActiveRecord::Migration
  def self.up
    add_column :sequences, :step_delay, :integer
  end

  def self.down
    remove_column :sequences, :step_delay
  end
end
