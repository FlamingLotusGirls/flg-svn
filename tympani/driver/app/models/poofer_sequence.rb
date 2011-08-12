class PooferSequence < ActiveRecord::Base

  belongs_to :poofer
  belongs_to :sequence

  def find_or_create_by_poofer_and_sequence_and_firing_time(poofer,sequence,firing_time)
    this_firing = PooferSequence.where(:poofer => poofer,:sequence => sequence,:time => firing_time)
    if this_firing.nil? then
      this_firing = PooferSequence.new(:poofer => poofer,:sequence => sequence,:time => firing_time, firing => false)
    end
    return this_firing
  end

end
