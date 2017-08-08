# frozen_string_literal: true

# Schedule model, used by DateBook to store event recurrence rules
class Schedule < Schedulable::Model::Schedule
  acts_as_schedule
end
