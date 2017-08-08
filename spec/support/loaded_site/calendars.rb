# frozen_string_literal: true

shared_context 'calendars' do
  let(:regular_calendar) { Calendar.friendly.find('regular-calendar') }
  let(:other_calendar) { Calendar.friendly.find('other-calendar') }
  let(:admin_calendar) { Calendar.friendly.find('admin-calendar') }
end
