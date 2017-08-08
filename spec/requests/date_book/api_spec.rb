# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DateBook API', folder: :requests do
  include_context 'loaded site'

  let(:calendar_query) do
    { query: '
{
  calendar(slug: "regular-calendar") {
    event_occurrences {
      url,
      popover_url,
      start,
      end,
      event {
        id,
        name,
        css_class,
        text_color,
        background_color,
        border_color,
        all_day
      }
    }
  }
}
' }
  end

  let(:event_occurrences_query) do
    { query: '
{
  event_occurrences {
    url,
    popover_url,
    start,
    end,
    event {
      id,
      name,
      css_class,
      text_color,
      background_color,
      border_color,
      all_day
    }
  }
}
' }
  end

  describe 'Browsing Events' do
    describe 'at /date_book/api' do
      describe 'with a global query' do
        before do
          post '/date_book/api.json', params: event_occurrences_query
        end
        it_behaves_like(
          'a graphql object listing a collection of items',
          EventOccurrence
        )
      end
      describe 'with a calendar query' do
        before do
          post '/date_book/api.json', params: calendar_query
        end
        it_behaves_like(
          'a graphql object showing an item',
          Calendar
        )
      end
    end
  end
end
