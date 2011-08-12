class Poofer < ActiveRecord::Base

  has_many :poofer_sequences;
  has_many :sequences, :through => :poofer_sequences;

  def initialize(board, relay)
    @board = board
    @relay = relay
  end

  def firing_at_time(time,sequence)
    if id%2 == 0 then
      return true
    else
      return false
    end
  end

end
