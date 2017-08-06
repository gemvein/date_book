shared_context 'events' do
  let(:monday_event) { Event.friendly.find('monday') }
  let(:science_fiction_club_event) { Event.friendly.find('science-fiction-club') }
  let(:yesterdays_event) { Event.friendly.find('yesterday-s-event') }
  let(:tomorrows_event) { Event.friendly.find('tomorrow-s-event') }
end
