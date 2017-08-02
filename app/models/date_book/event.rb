module DateBook
  class Event < ApplicationRecord
    alias_attribute :event_occurrences, :date_book_event_occurrences

    validates_presence_of :name, :slug

    # FriendlyId Gem
    extend FriendlyId
    friendly_id :name, use: :slugged

    # Schedulable Gem
    acts_as_schedulable :schedule, occurrences: :date_book_event_occurrences, class_name: 'DateBook::EventOccurrence'

    # Nested Forms gem
    accepts_nested_attributes_for :schedule

    # Rolify Gem
    resourcify

    scope :ending_after, -> (start_date) {
      where id: DateBook::EventOccurrence.ending_after(start_date).event_ids
    }
    scope :starting_before, -> (end_date) {
      where id: DateBook::EventOccurrence.starting_before(end_date).event_ids
    }

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

    def self.to_list
      DateBook::EventOccurrence
        .for_schedulables('DateBook::Event', ids)
        .ascending
        .map do |x|
          event = x.schedulable
          hashie = {
            occurrence_id: x.id,
            title: event.name,
            slug: event.slug,
            description: event.description,
            css_class: event.css_class,
            start_moment: x.start_moment,
            end_moment: x.end_moment,
            duration: event.schedule.duration,
            all_day: event.schedule.all_day
          }
          OpenStruct.new hashie
        end
    end
  end
end
