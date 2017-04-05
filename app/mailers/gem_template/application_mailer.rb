# frozen_string_literal: true

module GemTemplate
  # Some documentation goes here
  class ApplicationMailer < ActionMailer::Base
    default from: 'from@example.com'
    layout 'mailer'
  end
end
