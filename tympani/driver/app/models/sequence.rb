class Sequence < ActiveRecord::Base

  has_many :poofer_sequences;
  has_many :poofers, :through => :poofer_sequences;

  def firing_at_time(time,poofer)
    test = PooferSequence.where(:poofer_id => poofer,:sequence_id => id,:firing_time => time).first
    if test.nil? then
      return false
    else
      return test.firing
    end
  end
end
