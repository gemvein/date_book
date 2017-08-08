# frozen_string_literal: true

# Calendar model, used by DateBook to store groups of events
class Calendar < ApplicationRecord
  acts_as_calendar
end
