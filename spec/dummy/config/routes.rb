# frozen_string_literal: true

Rails.application.routes.draw do
  mount GemTemplate::Engine => '/gem_template'
end
