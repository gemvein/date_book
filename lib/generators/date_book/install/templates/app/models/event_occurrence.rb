# frozen_string_literal: true

# EventOccurrence model, used by DateBook to store times events occur
class EventOccurrence < ApplicationRecord
  acts_as_event_occurrence
end
