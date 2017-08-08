# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Calendars', folder: :features do
  include_context 'loaded site'

  include ActionView::Helpers::TextHelper
  let(:paragraphs) { %w[first second] }
  let!(:id) { regular_calendar.id }

  describe 'Browsing Calendars' do
    describe 'at /date_book/calendars' do
      before do
        # While we're not logged in:
        visit '/date_book/calendars'
      end
      it_behaves_like 'a bootstrap page showing an item', Calendar, 'Calendars'
    end
  end

  describe 'Showing Calendars' do
    describe 'at /date_book/calendars/regular-calendar' do
      before do
        visit '/date_book/calendars/regular-calendar'
      end
      it_behaves_like 'a bootstrap page showing an item', Calendar, 'Regular Calendar'
    end
  end

  describe 'Adding and Editing Calendars', js: true do
    describe 'Adding' do
      describe 'when not logged in' do
        before do
          # While we're not logged in:
          visit '/date_book/calendars/new'
        end
        it_behaves_like 'an authentication error'
      end
      describe 'when logged in' do
        before do
          login_as regular_user
          visit '/date_book/calendars/new'
        end
        it_behaves_like 'a bootstrap page', title: 'New Calendar'
        describe 'displays a form to add a new Calendar' do
          subject { page }
          it { should have_css('form#new_calendar') }
          it { should have_field('Name') }
          it { should have_text('Description') }
        end
        describe 'validates adding a Calendar' do
          before do
            fill_in 'Name', with: ''
            click_button 'Save Calendar'
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
        describe 'permits adding a valid Calendar', js: true do
          before do
            # Make travis wait
            wait_until do
              page.has_field? 'Name'
            end
            fill_in 'Name', with: 'Calendar Name Here'
            fill_in_wysiwyg(
              'Description',
              simple_format(paragraphs.join("\n\n"))
            )
            click_button 'Save Calendar'
            # Make travis wait
            wait_until do
              page.has_css? 'h1', text: 'Calendar Name Here'
            end
          end
          it_behaves_like(
            'a bootstrap page with an alert',
            'info',
            'Calendar was successfully created.'
          )
          it_behaves_like 'a bootstrap page', title: 'Calendar Name Here'
        end
      end
    end
    describe 'Editing' do
      describe 'when not logged in' do
        before do
          # While we're not logged in:
          visit '/date_book/calendars/regular-calendar/edit'
        end
        it_behaves_like 'an authentication error'
      end
      describe 'when logged in' do
        describe 'and not authorized' do
          before do
            login_as other_user
            visit '/date_book/calendars/regular-calendar/edit'
          end
          it_behaves_like 'an authorization error'
        end
        describe 'and authorized' do
          before do
            login_as regular_user
            visit '/date_book/calendars/regular-calendar/edit'
          end
          it_behaves_like 'a bootstrap page', title: 'Editing Regular Calendar'
          describe 'displays a form to edit the Calendar' do
            subject { page }
            it { should have_css("form#edit_calendar_#{id}") }
            it { should have_field('Name') }
            it { should have_text('Description') }
          end
          describe 'validates editing a Calendar' do
            before do
              # Make travis wait
              wait_until do
                page.has_field? 'Name'
              end
              fill_in 'Name', with: ''
              click_button 'Save Calendar'
              # Make travis wait
              wait_until do
                page.has_css? 'h1', text: 'Editing Regular Calendar'
              end
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
          describe 'permits editing a valid Calendar' do
            before do
              # Make travis wait
              wait_until do
                page.has_field? 'Name'
              end
              fill_in 'Name', with: 'Calendar Name Here'
              fill_in_wysiwyg(
                'Description',
                simple_format(paragraphs.join("\n\n"))
              )
              click_button 'Save Calendar'
              # Make travis wait
              wait_until do
                page.has_css? 'h1', text: 'Calendar Name Here'
              end
            end
            it_behaves_like(
              'a bootstrap page with an alert',
              'info',
              'Calendar was successfully updated.'
            )
            it_behaves_like 'a bootstrap page', title: 'Calendar Name Here'
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

  describe 'Removing Calendars' do
    describe 'when not logged in' do
      before do
        # While we're not logged in:
        page.driver.submit :delete, '/date_book/calendars/regular-calendar', {}
      end
      it_behaves_like 'an authentication error'
    end
    describe 'when logged in' do
      describe 'and not authorized' do
        before do
          login_as other_user
          page.driver.submit :delete, '/date_book/calendars/regular-calendar', {}
        end
        it_behaves_like 'an authorization error'
      end
      describe 'and authorized' do
        before do
          login_as regular_user
          page.driver.submit :delete, '/date_book/calendars/regular-calendar', {}
        end
        it_behaves_like 'a bootstrap page', title: 'Calendars'
        it_behaves_like(
          'a bootstrap page with an alert',
          'info',
          'Calendar was successfully removed.'
        )
        describe 'does not show the removed calendar' do
          subject { page }
          it { should_not have_selector "#calendar-#{id}" }
        end
      end
    end
  end
end
