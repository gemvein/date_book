shared_context 'events' do
  let(:monday_event) { DateBook::Event.friendly.find('monday') }
  let(:science_fiction_club_event) { DateBook::Event.friendly.find('science-fiction-club') }
end
