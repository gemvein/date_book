# frozen_string_literal: true

DateBook::Engine.routes.draw do
  resource :calendar
  resources :events
end
