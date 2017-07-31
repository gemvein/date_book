module DateBook
  class Event < ApplicationRecord
    # FriendlyId Gem
    extend FriendlyId
    friendly_id :name, use: :slugged

    # Schedulable Gem
    acts_as_schedulable :schedule, occurrences: :event_occurrences, class_name: '::EventOccurrence'

    # Rolify Gem
    resourcify

    scope :ending_after, -> (start_date) {
      where id: ::EventOccurrence.ending_after(start_date).event_ids
    }
    scope :starting_before, -> (end_date) {
      where id: ::EventOccurrence.starting_before(end_date).event_ids
    }

    def to_path
      Rails.application.routes.url_helpers.url_for [date_book, self]
    end

    def previous_occurrence
      event_occurrences.starting_before(Time.now).descending.first
    end

    def next_occurrence
      event_occurrences.ending_after(Time.now).ascending.first
    end

    def self.to_list
      ::EventOccurrence
        .for_schedulables('DateBook::Event', ids)
        .ascending
        .map do |x|
          event = x.schedulable
          hashie = {
            id: event.id,
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