# frozen_string_literal: true

Rails.application.routes.draw do
  mount DateBook::Engine => '/date_book'
end
