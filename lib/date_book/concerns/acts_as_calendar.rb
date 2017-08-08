# frozen_string_literal: true

module DateBook
  # Mixin to allow acts_as_calendar behavior in Calendar model
  module ActsAsCalendar
    def acts_as_calendar(_options = {})
      acts_as_ownable

      validates_presence_of :name, :slug

      # FriendlyId Gem
      extend FriendlyId
      friendly_id :name, use: :slugged

      # Relationships
      has_many :events, dependent: :destroy

      include InstanceMethods
    end

    # Instance Methods
    module InstanceMethods
      def event_occurrences
        events.as_occurrences.ascending
      end
    end
  end
end
