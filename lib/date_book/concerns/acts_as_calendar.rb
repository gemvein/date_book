# frozen_string_literal: true

module DateBook
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
      extend ClassMethods
    end

    module InstanceMethods
      def event_occurrences
        events.as_occurrences.ascending
      end
    end

    module ClassMethods
    end
  end
end
