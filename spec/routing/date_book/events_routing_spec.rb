require 'rails_helper'

module DateBook
  RSpec.describe EventsController, folder: :routing do
    routes { DateBook::Engine.routes }

    describe 'Routing' do
      it 'routes to #index' do
        expect(get: '/calendars/calendar-slug/events').
          to route_to(controller: 'date_book/events', action: 'index', calendar_id: 'calendar-slug')
      end

      it 'routes to #new' do
        expect(get: '/calendars/calendar-slug/events/new')
          .to route_to('date_book/events#new', calendar_id: 'calendar-slug')
      end

      it 'routes to #show' do
        expect(get: '/calendars/calendar-slug/events/slug')
          .to route_to('date_book/events#show', id: 'slug', calendar_id: 'calendar-slug')
      end

      it 'routes to #popover' do
        expect(get: '/calendars/calendar-slug/events/slug/popover')
          .to route_to('date_book/events#popover', id: 'slug', calendar_id: 'calendar-slug')
      end

      it 'routes to #edit' do
        expect(get: '/calendars/calendar-slug/events/slug/edit')
          .to route_to('date_book/events#edit', id: 'slug', calendar_id: 'calendar-slug')
      end

      it 'routes to #create' do
        expect(post: '/calendars/calendar-slug/events')
          .to route_to('date_book/events#create', calendar_id: 'calendar-slug')
      end

      it 'routes to #update via PUT' do
        expect(put: '/calendars/calendar-slug/events/slug')
          .to route_to('date_book/events#update', id: 'slug', calendar_id: 'calendar-slug')
      end

      it 'routes to #update via PATCH' do
        expect(patch: '/calendars/calendar-slug/events/slug')
          .to route_to('date_book/events#update', id: 'slug', calendar_id: 'calendar-slug')
      end

      it 'routes to #destroy' do
        expect(delete: '/calendars/calendar-slug/events/slug')
          .to route_to('date_book/events#destroy', id: 'slug', calendar_id: 'calendar-slug')
      end
    end
  end
end
