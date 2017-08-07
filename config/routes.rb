# frozen_string_literal: true

DateBook::Engine.routes.draw do
  post 'api', to: "graphql#execute"

  resources :calendars do
    resources :events do
      get 'popover', on: :member
    end
  end
  root to: 'calendar#index'
end
