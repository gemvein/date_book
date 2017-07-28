# frozen_string_literal: true

module DateBook
  # Some documentation goes here
  class Engine < ::Rails::Engine
    isolate_namespace DateBook
    engine_name 'date_book'

    config.generators do |g|
      g.hidden_namespaces << 'test_unit' << 'erb'
      g.orm             :active_record
      g.template_engine :haml
      g.test_framework  :rspec, fixture: false
      g.integration_tool :rspec
      g.stylesheets     false
      g.javascripts     false
      g.view_specs      false
      g.helper_specs    false
    end

    initializer 'date_book.assets.precompile' do |app|
      app.config.assets.precompile += %w( date_book.js date_book.css )
    end

    def self.table_name_prefix
      'date_book_'
    end
  end
end
