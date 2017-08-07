# frozen_string_literal: true

module DateBook
  # DateBook Install Generator
  class InstallGenerator < Rails::Generators::Base
    argument :user_model_name, type: :string, default: 'User'
    source_root File.expand_path('../templates', __FILE__)
    require File.expand_path('../../utils', __FILE__)
    include Generators::Utils
    include Rails::Generators::Migration

    def hello
      output 'DateBook Installer will now install itself', :magenta
    end

    # all public methods in here will be run in order

    def install_devise
      output(
        'To start with, Devise is used to authenticate users. No need to '\
          "install it separately, I'll do that now.", :magenta
      )
      generate('devise:install')
      generate('devise User')
    end

    def install_cancan
      output(
        "For authorization, DateBook uses CanCanCan. Let's get you started "\
          'with a customizable ability.rb file.',
        :magenta
      )
      template 'app/models/ability.rb', 'app/models/ability.rb'
    end

    def install_rolify
      output(
        "To provide varying roles for Users, we'll use Rolify. Let's set that "\
          'up now.',
        :magenta
      )
      generate('rolify', 'Role User')
    end

    def install_bootstrap_leather
      output(
        'To make building in bootstrap easier, we use Bootstrap Leather.',
        :magenta
      )
      generate('bootstrap_leather:install')
    end

    def add_initializer
      output(
        "Next, you'll need an initializer for Date Book.",
        :magenta
      )
      template 'config/initializers/date_book.rb', 'config/initializers/date_book.rb'
    end

    def add_models
      output(
        'Models for you to extend will be placed in your models directory',
        :magenta
      )
      template 'app/models/calendar.rb', 'app/models/calendar.rb'
      template 'app/models/event.rb', 'app/models/event.rb'
      template 'app/models/event_occurrence.rb', 'app/models/event_occurrence.rb'
      template 'app/models/schedule.rb', 'app/models/schedule.rb'
    end

    def add_to_user
      output 'Adding DateBook to your User model', :magenta
      gsub_file(
        'app/models/user.rb',
        %r{acts_as_owner},
        ''
      )
      inject_into_file 'app/models/user.rb', after: "rolify\n" do
<<-'RUBY'
  acts_as_owner
RUBY
      end
    end

    def add_migrations
      output 'Next come migrations.', :magenta
      rake 'date_book:install:migrations'
    end

    # def add_to_model
    #   output 'Adding DateBook to your User model', :magenta
    #   gsub_file 'app/models/user.rb', /^\n  subscriber$/, ''
    #   inject_into_file(
    #     'app/models/user.rb', "\n  subscriber",
    #     after: 'class User < ActiveRecord::Base'
    #   )
    # end

    def add_route
      output 'Adding DateBook to your routes.rb file', :magenta
      gsub_file(
        'config/routes.rb',
        %r{mount DateBook::Engine => '/.*', as: 'date_book'},
        ''
      )
      route("mount DateBook::Engine => '/date_book', as: 'date_book'")
    end
  end
end
