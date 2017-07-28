# frozen_string_literal: true

module DateBook
  # Some documentation goes here
  class DateBookController < ::ApplicationController
    protect_from_forgery with: :exception
    helper :all
    before_action :set_locale

    private

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end
  end
end
