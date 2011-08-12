class AddStepsToSequence < ActiveRecord::Migration
  def self.up
    add_column :sequences, :steps, :integer
  end

  def self.down
    remove_column :sequences, :steps
  end
end
