# frozen_string_literal: true

DateBook::Engine.routes.draw do
  resources :calendars
  resources :events do
    get 'popover', on: :member
  end
  root to: 'calendar#index'
end
