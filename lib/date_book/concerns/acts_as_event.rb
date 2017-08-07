module DateBook
  module ActsAsEvent
    def acts_as_event(options = {})
      acts_as_ownable

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
      scope :ending_after, -> (start_date) {
        where id: ::EventOccurrence.ending_after(start_date).event_ids
      }
      scope :starting_before, -> (end_date) {
        where id: ::EventOccurrence.starting_before(end_date).event_ids
      }

      include InstanceMethods
      extend ClassMethods
    end

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

      def to_list(occurrence = nil)
        occurrence ||= next_occurrence
        hashie = {
          occurrence_id: occurrence.id,
          title: name,
          slug: slug,
          description: description,
          css_class: css_class,
          start_moment: occurrence.start_moment,
          end_moment: occurrence.end_moment,
          duration: schedule.duration,
          all_day: schedule.all_day
        }
        OpenStruct.new(hashie).marshal_dump
      end
    end

    module ClassMethods
      def to_list
        ::EventOccurrence
          .for_schedulables('Event', ids)
          .ascending
          .map { |x| x.schedulable.to_list(x) }
      end
    end

  end
end
