module DateBook
  class Event < ApplicationRecord
    # FriendlyId Gem
    extend FriendlyId
    friendly_id :name, use: :slugged

    # Schedulable Gem
    acts_as_schedulable :schedule
  end
end
