# frozen_string_literal: true

Rails.application.routes.draw do
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  mount DateBook::Engine => '/date_book', as: 'date_book'
  devise_for :users
  
end
