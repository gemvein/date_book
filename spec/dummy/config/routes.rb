# frozen_string_literal: true

Rails.application.routes.draw do
  mount DateBook::Engine => '/', as: 'date_book'
  mount DateBook::Engine => '/date_book'
end
