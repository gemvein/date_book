# frozen_string_literal: true

Rails.application.routes.draw do

  
  
  mount DateBook::Engine => '/date_book', as: 'date_book'
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/date_book/api"
  end
  
  
  devise_for :users
  
end
