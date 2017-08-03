# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :users
  mount DateBook::Engine => '/date_book', as: 'date_book'
end
