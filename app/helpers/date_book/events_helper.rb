# frozen_string_literal: true

module DateBook
  module EventsHelper
    def date_book_event_occurrence_dates(event)
      render partial: 'date_book/events/occurrence_dates', locals: { event: event }
    end

    def date_book_rule_form_section(rule, form_section)
      render partial: "date_book/events/rules/#{rule}", locals: { f: form_section }
    end

    def date_book_date_field(form_section)
      render partial: 'date_book/events/fields/date', locals: { f: form_section }
    end

    def date_book_time_field(form_section)
      render partial: 'date_book/events/fields/time', locals: { f: form_section }
    end

    def date_book_duration_field(form_section)
      render partial: 'date_book/events/fields/duration', locals: { f: form_section }
    end

    def date_book_interval_field(unit, form_section)
      render partial: 'date_book/events/fields/interval', locals: { f: form_section, unit: unit }
    end

    def date_book_day_field(form_section)
      render partial: 'date_book/events/fields/day', locals: { f: form_section }
    end

    def date_book_day_of_week_field(form_section)
      render partial: 'date_book/events/fields/day_of_week', locals: { f: form_section }
    end
  end
end
