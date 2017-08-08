# frozen_string_literal: true

require 'rails_helper'

module DateBook
  RSpec.describe CalendarsController, folder: :routing do
    routes { DateBook::Engine.routes }

    describe 'Routing' do
      it 'routes to #index' do
        expect(get: '/calendars')
          .to route_to(controller: 'date_book/calendars', action: 'index')
      end

      it 'routes to #new' do
        expect(get: '/calendars/new')
          .to route_to('date_book/calendars#new')
      end

      it 'routes to #show' do
        expect(get: '/calendars/slug')
          .to route_to('date_book/calendars#show', id: 'slug')
      end

      it 'routes to #edit' do
        expect(get: '/calendars/slug/edit')
          .to route_to('date_book/calendars#edit', id: 'slug')
      end

      it 'routes to #create' do
        expect(post: '/calendars')
          .to route_to('date_book/calendars#create')
      end

      it 'routes to #update via PUT' do
        expect(put: '/calendars/slug')
          .to route_to('date_book/calendars#update', id: 'slug')
      end

      it 'routes to #update via PATCH' do
        expect(patch: '/calendars/slug')
          .to route_to('date_book/calendars#update', id: 'slug')
      end

      it 'routes to #destroy' do
        expect(delete: '/calendars/slug')
          .to route_to('date_book/calendars#destroy', id: 'slug')
      end
    end
  end
end
