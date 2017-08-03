# frozen_string_literal: true

DateBook::Engine.routes.draw do
  resource :calendar
  resources :events do
    get 'popover', on: :member
  end
  root to: 'calendar#index'
end
