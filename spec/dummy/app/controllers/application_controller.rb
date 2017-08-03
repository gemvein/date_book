# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      Rails.logger.debug "Access denied on #{exception.action} "\
                         "#{exception.subject.inspect}"
      flash.now[:error] = exception.message
      render '403', status: :forbidden, layout: 'application'
    else
      redirect_to(
        main_app.root_url,
        flash: {
          error: 'You must sign in or sign up to access this content.'
        }
      )
    end
  end
end
