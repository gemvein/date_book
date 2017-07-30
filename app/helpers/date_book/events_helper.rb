module DateBook
  module EventsHelper
    def event_next_occurrence_dates(event)
      next_occurrence = event.next_occurrence
      render partial: 'date_book/events/dates', locals: {
        start_date: next_occurrence.start_date,
        end_date: next_occurrence.end_date,
        all_day: event.schedule.all_day,
        duration: event.schedule.duration
      }
    end

  end
end
