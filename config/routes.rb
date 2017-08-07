# frozen_string_literal: true

DateBook::Engine.routes.draw do
  resources :calendars do
    resources :events do
      get 'popover', on: :member
    end
  end
  root to: 'calendar#index'
end
