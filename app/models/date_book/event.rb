module DateBook
  class Event < ApplicationRecord
    # FriendlyId Gem
    extend FriendlyId
    friendly_id :name, use: :slugged

    # Schedulable Gem
    acts_as_schedulable :schedule

    # Rolify Gem
    resourcify

    scope :ending_after, -> (start_date) { where nil }
    scope :starting_before, -> (end_date) { where nil }
  end
end
