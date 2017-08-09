# frozen_string_literal: true

require 'date_book/engine'

# DateBook module
module DateBook
  require 'rails-i18n'

  require 'devise'
  require 'rack/cors'
  require 'cancan'
  require 'rolify'

  require 'sass'
  require 'sass-rails'
  require 'haml-rails'
  require 'bootstrap-sass'
  require 'bootstrap_leather'
  require 'bootstrap_form'
  require 'bootstrap-wysihtml5-rails'
  require 'font-awesome-rails'

  require 'schedulable'
  require 'fullcalendar-rails'
  require 'momentjs-rails'
  require 'bootstrap3-datetimepicker-rails'

  require 'graphql'

  require 'date_book/configuration'
  require 'date_book/engine'
  require 'date_book/localization'
  require 'date_book/version'

  require 'date_book/concerns/ability'
  require 'date_book/concerns/acts_as_calendar'
  require 'date_book/concerns/acts_as_event'
  require 'date_book/concerns/acts_as_event_occurrence'
  require 'date_book/concerns/acts_as_ownable'
  require 'date_book/concerns/acts_as_owner'
  require 'date_book/concerns/acts_as_schedule'
end

ActiveRecord::Base.send(:extend, DateBook::ActsAsOwnable)
ActiveRecord::Base.send(:extend, DateBook::ActsAsOwner)
ActiveRecord::Base.send(:extend, DateBook::ActsAsCalendar)
ActiveRecord::Base.send(:extend, DateBook::ActsAsEvent)
ActiveRecord::Base.send(:extend, DateBook::ActsAsEventOccurrence)
ActiveRecord::Base.send(:extend, DateBook::ActsAsSchedule)
