require 'rails_helper'

RSpec.feature 'Events', folder: :features do
  include_context 'loaded site'

  include ActionView::Helpers::TextHelper
  let(:paragraphs) { %w(first second) }
  let!(:club_id) { science_fiction_club_event.id }

  describe 'Browsing Events' do
    describe 'at /date_book/events' do
      describe 'without a query' do
        before do
          # While we're not logged in:
          visit '/date_book/events'
        end
        it_behaves_like(
          'a bootstrap page listing a collection of items',
          DateBook::Event,
          minimum: 5
        )
      end
      describe 'with a query' do
        before do
          visit "/date_book/events?start=#{Date.today}"
        end
        it_behaves_like(
          'a bootstrap page listing a collection of items',
          DateBook::Event,
          minimum: 4
        )
      end
    end
  end

  describe 'Showing Events' do
    describe 'at /date_book/events/monday' do
      before do
        visit '/date_book/events/monday'
      end
      it_behaves_like 'a bootstrap page showing an item', DateBook::Event, 'Monday'
    end
  end

  describe 'Adding and Editing Events', js: true do
    describe 'Adding' do
      describe 'when not logged in' do
        before do
          # While we're not logged in:
          visit '/date_book/events/new'
        end
        it_behaves_like 'an authentication error'
      end
      describe 'when logged in' do
        before do
          login_as regular_user
          visit '/date_book/events/new'
        end
        it_behaves_like 'a bootstrap page', title: 'New Event'
        describe 'displays a form to add a new Event' do
          subject { page }
          it { should have_css('form#new_event') }
          it { should have_field('Name') }
          it { should have_text('Description') }
        end
        describe 'validates adding a Event' do
          before do
            fill_in 'Name', with: ''
            click_button 'Save'
          end
          subject { page }
          it_behaves_like(
            'a bootstrap page with an alert',
            'danger',
            "Name can't be blank"
          )
          it 'shows errors on name' do
            expect(page.has_css?('[id$=name]')).to be true
          end
        end
        describe 'permits adding a valid Event', js: true do
          before do
            fill_in 'Name', with: 'Event Name Here'
            fill_in_wysiwyg(
              'Description',
              simple_format(paragraphs.join("\n\n"))
            )
            click_button 'Save'
          end
          it_behaves_like(
            'a bootstrap page with an alert',
            'info',
            'Event was successfully created.'
          )
          it_behaves_like 'a bootstrap page', title: 'Event Name Here'
        end
      end
    end
    describe 'Editing' do
      describe 'when not logged in' do
        before do
          # While we're not logged in:
          visit '/date_book/events/science-fiction-club/edit'
        end
        it_behaves_like 'an authentication error'
      end
      describe 'when logged in' do
        describe 'and not authorized' do
          before do
            login_as other_user
            visit '/date_book/events/science-fiction-club/edit'
          end
          it_behaves_like 'an authorization error'
        end
        describe 'and authorized' do
          before do
            login_as regular_user
            visit '/date_book/events/science-fiction-club/edit'
          end
          it_behaves_like 'a bootstrap page', title: 'Editing Science Fiction Club'
          describe 'displays a form to edit the Event' do
            subject { page }
            it { should have_css("form#edit_event_#{club_id}") }
            it { should have_field('Name') }
            it { should have_text('Description') }
          end
          describe 'validates editing a Event' do
            before do
              fill_in 'Name', with: ''
              click_button 'Save'
            end
            it_behaves_like(
              'a bootstrap page with an alert',
              'danger',
              "Name can't be blank"
            )
            it 'shows errors on name' do
              expect(page.has_css?('[id$=name]')).to be true
            end
          end
          describe 'permits editing a valid Event' do
            before do
              fill_in 'Name', with: 'Event Name Here'
              fill_in_wysiwyg(
                'Description',
                simple_format(paragraphs.join("\n\n"))
              )
              click_button 'Save'
            end
            it_behaves_like(
              'a bootstrap page with an alert',
              'info',
              'Event was successfully updated.'
            )
            it_behaves_like 'a bootstrap page', title: 'Event Name Here'
            describe 'parses the description correctly' do
              subject { page }
              it { should have_selector 'p', text: paragraphs.first }
              it { should have_selector 'p', text: paragraphs.second }
            end
          end
        end
      end
    end
  end

  describe 'Removing Events' do
    describe 'when not logged in' do
      before do
        # While we're not logged in:
        page.driver.submit :delete, '/date_book/events/science-fiction-club', {}
      end
      it_behaves_like 'an authentication error'
    end
    describe 'when logged in' do
      describe 'and not authorized' do
        before do
          login_as other_user
          page.driver.submit :delete, '/date_book/events/science-fiction-club', {}
        end
        it_behaves_like 'an authorization error'
      end
      describe 'and authorized' do
        before do
          login_as regular_user
          page.driver.submit :delete, '/date_book/events/science-fiction-club', {}
        end
        it_behaves_like 'a bootstrap page', title: 'Events'
        it_behaves_like(
          'a bootstrap page with an alert',
          'info',
          'Event was successfully removed.'
        )
        describe 'does not show the removed event' do
          subject { page }
          it { should_not have_selector "#date-book-event-#{club_id}" }
        end
      end
    end
  end
end
