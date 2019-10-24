class Event < ApplicationRecord
  belongs_to :user

  serialize :recurring, Hash

  def recurring=(value)
    if RecurringSelect.is_valid_rule?(value) && value != 'null'
      super(RecurringSelect.dirty_hash_to_rule(value).to_hash)
    else
      super(nil)
    end
  end

  def rule
    IceCube::Rule.from_hash recurring
  end

  def schedule(start)
    schedule = IceCube::Schedule.new(start)
    schedule.add_recurrence_rule(rule)
    schedule
  end

  def calendar_events(start)
    if recurring.empty?
      [self]
    else
      end_date = start.end_of_month.end_of_week
      schedule(start_time).occurrences(end_date).map do |date|
        Event.new(id: id, title: title, start_time: date)
      end
    end
  end
end
