# frozen_string_literal: true

require 'date_book/engine'

module DateBook
  require 'rails-i18n'

  require 'devise' # Needs to be required before paid_up/mixins
  require 'cancan'
  require 'rolify'

  require 'sass'
  require 'haml-rails'
  require 'bootstrap_leather'

  require 'fullcalendar-rails'

  require 'date_book/configuration'
  require 'date_book/engine'
  require 'date_book/localization'
  require 'date_book/version'
end
