# frozen_string_literal: true

# Event model, used by DateBook to store events (recurring and not)
class Event < ApplicationRecord
  acts_as_event
end
