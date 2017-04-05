# frozen_string_literal: true

module GemTemplate
  # Some documentation goes here
  class Engine < ::Rails::Engine
    isolate_namespace GemTemplate
    config.generators do |g|
      g.hidden_namespaces << :test_unit << :mongoid
      g.orm             :active_record
      g.template_engine :haml
      g.test_framework  :rspec, fixture: false
      g.stylesheets     false
      g.javascripts     false
    end
  end
end
