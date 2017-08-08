# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Events Requests', folder: :requests do
  include_context 'loaded site'

  let(:valid_attributes) do
    { event: { name: 'Test Event', schedule_attributes: { date: Date.today, time: Time.zone.now } } }
  end

  let(:invalid_attributes) do
    { event: { name: nil } }
  end

  pending 'Browsing Events' do
    describe 'at /date_book/events' do
      describe 'without a query' do
        before do
          get '/date_book/events.json'
        end
        it_behaves_like(
          'a json object listing a collection of items',
          Event,
          minimum: 2
        )
      end
      describe 'with a query' do
        before do
          get(
            '/date_book/events.json',
            params: {
              start: Date.today
            }
          )
        end
        it_behaves_like(
          'a json object listing a collection of items',
          Event,
          minimum: 1
        )
      end
    end
  end

  pending 'Showing Events' do
    describe 'at /date_book/events/monday' do
      before do
        get '/date_book/events/monday.json'
      end
      it_behaves_like(
        'a json object showing an item',
        Event,
        'Monday'
      )
    end
  end
end
