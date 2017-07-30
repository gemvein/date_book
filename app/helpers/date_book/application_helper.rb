# frozen_string_literal: true

module DateBook
  # Some documentation goes here
  module ApplicationHelper
    def date_book_scripts
      render partial: 'layout/date_book_scripts'
    end

    def render_date(date, all_day = false)
      format = if all_day
                 :human_date
               else
                 :human_datetime
               end
      I18n.localize date, format: format
    end
  end
end
