class Event < ApplicationRecord
  belongs_to :diary

  def end_time_to_string_nil_safe
    "" unless self.end_time
    self.end_time.strftime('%H:%M') if self.end_time
  end

  def times_string
    if self.end_time
     "#{self.start_time.strftime('%H:%M')} ~ #{self.end_time.strftime('%H:%M')}"
    else
      self.start_time.strftime('%H:%M')
    end
  end
end
