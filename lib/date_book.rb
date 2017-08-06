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
  require 'bootstrap_form'
  require 'bootstrap-wysihtml5-rails'

  require 'schedulable'
  require 'fullcalendar-rails'

  require 'date_book/configuration'
  require 'date_book/engine'
  require 'date_book/localization'
  require 'date_book/version'

  require 'date_book/concerns/ability'
  require 'date_book/concerns/acts_as_event'
  require 'date_book/concerns/acts_as_event_occurrence'
  require 'date_book/concerns/acts_as_ownable'
  require 'date_book/concerns/acts_as_schedule'
end

ActiveRecord::Base.send(:extend, DateBook::ActsAsOwnable)
ActiveRecord::Base.send(:extend, DateBook::ActsAsEvent)
ActiveRecord::Base.send(:extend, DateBook::ActsAsEventOccurrence)
ActiveRecord::Base.send(:extend, DateBook::ActsAsSchedule)