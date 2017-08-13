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
      app.config.assets.precompile += %w[
        date_book.js date_book.css bootstrap-wysiwyg/bootstrap-wysiwyg.css
        bootstrap-wysiwyg.js jquery_nested_form.js jquery_nested_form.js
        bootstrap-datetimepicker.js bootstrap-datetimepicker.css all-day-bg.png
        part-day-bg.png moment.js glyphicons-halflings-regular.eot
        glyphicons-halflings-regular.svg glyphicons-halflings-regular.ttf
        glyphicons-halflings-regular.woff glyphicons-halflings-regular.woff2
      ]
    end

    initializer 'date_book.add_middleware' do |app|
      app.config.middleware.insert_before 0, Rack::Cors do
        allow do
          origins %r{\Ahttps?://localhost:?[0-9]+\z}
          resource '*', headers: :any, methods: %i[get post options]
        end
      end

      app.config.middleware.insert_before Warden::Manager, Rack::Cors
    end
  end
end
