# frozen_string_literal: true

module DateBook
  module EventsHelper
    def date_book_event_occurrence_dates(event)
      render partial: 'date_book/events/occurrence_dates', locals: { event: event }
    end

    def date_book_rule_form_section(rule, schedule)
      render partial: "date_book/events/rules/#{rule}", locals: { schedule: schedule }
    end

    def date_book_date_field(schedule)
      render partial: 'date_book/events/fields/date', locals: { schedule: schedule }
    end

    def date_book_time_field(schedule)
      render partial: 'date_book/events/fields/time', locals: { schedule: schedule }
    end

    def date_book_duration_field(schedule)
      render partial: 'date_book/events/fields/duration', locals: { schedule: schedule }
    end

    def date_book_interval_field(unit, schedule)
      render partial: 'date_book/events/fields/interval', locals: { schedule: schedule, unit: unit }
    end

    def date_book_day_field(schedule)
      render partial: 'date_book/events/fields/day', locals: { schedule: schedule }
    end

    def date_book_day_of_week_field(schedule)
      render partial: 'date_book/events/fields/day_of_week', locals: { schedule: schedule }
    end
  end
end
