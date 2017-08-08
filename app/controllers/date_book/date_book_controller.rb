# frozen_string_literal: true

module DateBook
  # Main DateBookController, all others inherit from this
  class DateBookController < ::ApplicationController
    helper :all
    before_action :set_locale

    # Prevent CSRF attacks using :exception in the main app
    # and :null_session in the API
    protect_from_forgery with: :exception, unless: :api_request?
    protect_from_forgery with: :null_session, if: :api_request?

    private

    def api_request?
      request.format.json?
    end

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end
  end
end
