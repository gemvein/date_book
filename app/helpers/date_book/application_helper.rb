# frozen_string_literal: true

module DateBook
  # Global helpers, used mostly to format dates smartly
  module ApplicationHelper
    def date_book_scripts
      render partial: 'layouts/date_book_scripts'
    end

    def date_book_date_range(start_date, end_date, all_day, duration)
      render partial: 'date_book/application/date_range', locals: {
        start_date: start_date,
        end_date: end_date,
        all_day: all_day,
        duration: duration
      }
    end

    def date_book_date(date, all_day = false)
      format = if all_day
                 :human_date
               else
                 :human_datetime
               end
      I18n.localize date, format: format
    end

    def date_book_time(date)
      I18n.localize date, format: :human_time
    end
  end
end
