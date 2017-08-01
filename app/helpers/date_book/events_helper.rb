module DateBook
  module EventsHelper
    def event_occurrence_dates(event)
      render partial: 'date_book/events/occurrence_dates', locals: { event: event }
    end

    def event_popover(event)
      render partial: 'date_book/events/popover', locals: {
        event: event
      }, formats: :html
    end

    def render_rule_form_section(rule, schedule)
      render partial: "date_book/events/#{rule}", locals: { schedule: schedule }
    end

  end
end
