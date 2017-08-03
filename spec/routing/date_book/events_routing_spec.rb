require 'rails_helper'

module DateBook
  RSpec.describe EventsController, folder: :routing do
    routes { DateBook::Engine.routes }

    describe 'Routing' do
      it 'routes to #index' do
        expect(get: '/events').
          to route_to(controller: 'date_book/events', action: 'index')
      end

      it 'routes to #new' do
        expect(get: '/events/new')
          .to route_to('date_book/events#new')
      end

      it 'routes to #show' do
        expect(get: '/events/slug')
          .to route_to('date_book/events#show', id: 'slug')
      end

      it 'routes to #show' do
        expect(get: '/events/slug/popover')
          .to route_to('date_book/events#popover', id: 'slug')
      end

      it 'routes to #edit' do
        expect(get: '/events/slug/edit')
          .to route_to('date_book/events#edit', id: 'slug')
      end

      it 'routes to #create' do
        expect(post: '/events')
          .to route_to('date_book/events#create')
      end

      it 'routes to #update via PUT' do
        expect(put: '/events/slug')
          .to route_to('date_book/events#update', id: 'slug')
      end

      it 'routes to #update via PATCH' do
        expect(patch: '/events/slug')
          .to route_to('date_book/events#update', id: 'slug')
      end

      it 'routes to #destroy' do
        expect(delete: '/events/slug')
          .to route_to('date_book/events#destroy', id: 'slug')
      end
    end
  end
end
