# frozen_string_literal: true

module DateBook
  # Mixin to allow acts_as_event behavior in Event model
  module ActsAsEvent
    def acts_as_event(_options = {})
      acts_as_ownable

      delegate :all_day, :duration, to: :schedule

      validates_presence_of :name, :slug, :calendar

      # FriendlyId Gem
      extend FriendlyId
      friendly_id :name, use: :slugged

      # Schedulable Gem
      acts_as_schedulable :schedule, occurrences: :event_occurrences

      # Relationships
      belongs_to :calendar

      # Nested Forms gem
      accepts_nested_attributes_for :schedule

      # Scopes
      scope :ending_after, ->(start_date) {
        where id: ::EventOccurrence.ending_after(start_date).event_ids
      }
      scope :starting_before, ->(end_date) {
        where id: ::EventOccurrence.starting_before(end_date).event_ids
      }

      include InstanceMethods
      extend ClassMethods
    end

    # Instance Methods
    module InstanceMethods
      def schedule
        super || build_schedule(date: Time.now.to_date, time: Time.now.to_s(:time))
      end

      def previous_occurrence(occurrence = nil)
        before = occurrence.present? ? occurrence.start_date : Time.now
        event_occurrences.starting_before(before).descending.first
      end

      def next_occurrence(occurrence = nil)
        after = occurrence.present? ? occurrence.end_date + 1.second : Time.now
        event_occurrences.ending_after(after).ascending.first
      end

      def url(occurrence = nil)
        DateBook::Engine.routes.url_helpers.calendar_event_path(calendar, slug, occurrence_id: occurrence&.id)
      end

      def popover_url(occurrence = nil)
        DateBook::Engine.routes.url_helpers.popover_calendar_event_path(calendar, slug, occurrence_id: occurrence&.id)
      end
    end

    # Class Methods
    module ClassMethods
      def as_occurrences
        ::EventOccurrence.for_schedulables('Event', ids)
      end
    end
  end
end
