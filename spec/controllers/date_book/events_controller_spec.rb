# frozen_string_literal: true

require 'rails_helper'

module DateBook
  RSpec.describe EventsController, folder: :controllers do
    routes { DateBook::Engine.routes }

    include_context 'loaded site'
    include ControllerMacros

    # This should return the minimal set of attributes required to create a
    # valid Event. As you add validations to Event, be sure to adjust the
    # attributes here as well.
    let(:valid_attributes) do
      {
        name: 'Test Event',
        schedule_attributes: { date: 1.hour.ago.to_date, time: 1.hour.ago }
      }
    end

    let(:invalid_attributes) do
      { name: nil, schedule_attributes: nil }
    end

    describe 'GET #index' do
      describe 'without a query' do
        before do
          get :index, params: { calendar_id: 'admin-calendar' }
        end
        it_should_behave_like 'a successful page', which_renders: 'index'

        describe 'loads events into @events' do
          subject { assigns(:events) }
          it { should include yesterdays_event }
          it { should include tomorrows_event }
        end
      end
      describe 'with a query' do
        before do
          get(
            :index,
            params: { start: Time.zone.now, calendar_id: 'admin-calendar' }
          )
        end
        it_should_behave_like 'a successful page', which_renders: 'index'

        describe 'loads events into @events' do
          subject { assigns(:events) }
          it { should_not include yesterdays_event }
          it { should include tomorrows_event }
        end
      end
    end

    describe 'GET #show' do
      before do
        get(
          :show,
          params: { id: 'the-work-week', calendar_id: 'admin-calendar' }
        )
      end
      it_should_behave_like 'a successful page', which_renders: 'show'
    end

    describe 'GET #popover' do
      before do
        get(
          :popover,
          params: { id: 'the-work-week', calendar_id: 'admin-calendar' }
        )
      end
      it_should_behave_like 'a successful page', which_renders: 'popover'
    end

    describe 'GET #new' do
      describe 'when not logged in' do
        before do
          # Here's where we are *not* logging in
          get :new, params: { calendar_id: 'regular-calendar' }
        end
        it_should_behave_like 'a redirect to the home page'
      end
      describe 'when logged in' do
        before do
          login_user regular_user
          get :new, params: { calendar_id: 'regular-calendar' }
        end
        it_should_behave_like 'a successful page', which_renders: 'new'

        describe 'loads a new event into @event' do
          subject { assigns(:event) }
          it { should be_a_new Event }
          its(:schedule) { should be_a_new Schedule }
        end
      end
    end

    describe 'GET #edit' do
      describe 'when not logged in' do
        before do
          # Here's where we are *not* logging in
          get(
            :edit,
            params: { id: 'the-work-week', calendar_id: 'admin-calendar' }
          )
        end
        it_should_behave_like 'a redirect to the home page'
      end
      describe 'when logged in' do
        describe 'as someone other than the owner' do
          before do
            login_user regular_user
            get(
              :edit,
              params: { id: 'the-work-week', calendar_id: 'admin-calendar' }
            )
          end
          it_should_behave_like 'a 403 Forbidden error'
        end
        describe 'as the owner' do
          before do
            login_user regular_user
            get(
              :edit,
              params: {
                id: 'science-fiction-club',
                calendar_id: 'regular-calendar'
              }
            )
          end
          it_should_behave_like 'a successful page', which_renders: 'edit'

          describe 'loads requested event into @event' do
            subject { assigns(:event) }
            it { should eq science_fiction_club }
          end
        end
      end
    end

    describe 'POST #create' do
      describe 'when not logged in' do
        before do
          # Here's where we are *not* logging in
          post(
            :create,
            params: { event: valid_attributes, calendar_id: 'regular-calendar' }
          )
        end
        it_should_behave_like 'a redirect to the home page'
      end
      describe 'when logged in' do
        describe 'with valid params' do
          before do
            login_user regular_user
            post(
              :create,
              params: {
                event: valid_attributes,
                calendar_id: 'regular-calendar'
              }
            )
          end
          it_should_behave_like(
            'a redirect to',
            '/date_book/calendars/regular-calendar/events/test-event'
          )
          describe "sets the flash with a notice of the event's creation" do
            subject { flash[:notice] }
            it { should eq 'Event was successfully created.' }
          end
        end
        describe 'with valid params, counting' do
          before do
            login_user regular_user
          end
          it 'results in a new event' do
            expect do
              post(
                :create,
                params: {
                  event: valid_attributes,
                  calendar_id: 'regular-calendar'
                }
              )
            end.to change { Event.count(:id) }.by(1)
          end
        end
        describe 'with invalid params' do
          before do
            login_user regular_user
            post(
              :create,
              params: {
                event: invalid_attributes,
                calendar_id: 'regular-calendar'
              }
            )
          end
          it_should_behave_like 'a successful page', which_renders: 'new'

          describe "sets the flash with the event's errors" do
            subject { flash[:error] }
            it { should eq "Name can't be blank" }
          end
        end
        describe 'with invalid params, counting' do
          before do
            login_user regular_user
          end
          it 'does not result in a new event' do
            expect do
              post(
                :create,
                params: {
                  event: invalid_attributes,
                  calendar_id: 'regular-calendar'
                }
              )
            end.to_not(change { Event.count(:id) })
          end
        end
      end
    end

    describe 'PUT #update' do
      describe 'when not logged in' do
        before do
          # Here's where we are *not* logging in
          put(
            :update,
            params: {
              id: 'science-fiction-club',
              event: valid_attributes,
              calendar_id: 'regular-calendar'
            }
          )
        end
        it_should_behave_like 'a redirect to the home page'
      end
      describe 'when logged in' do
        describe 'as someone other than the owner' do
          before do
            login_user other_user
            put(
              :update,
              params: {
                id: 'science-fiction-club',
                event: valid_attributes,
                calendar_id: 'regular-calendar'
              }
            )
          end
          it_should_behave_like 'a 403 Forbidden error'
        end
        describe 'as the owner' do
          describe 'with valid params' do
            before do
              login_user regular_user
              put(
                :update,
                params: {
                  id: 'science-fiction-club',
                  event: valid_attributes,
                  calendar_id: 'regular-calendar'
                }
              )
            end
            # Note that slug does not change
            it_should_behave_like(
              'a redirect to',
              '/date_book/calendars/regular-calendar/events/'\
                'science-fiction-club'
            )

            describe 'updates @event' do
              subject { science_fiction_club.reload }
              its(:name) { should eq 'Test Event' }
            end

            describe "sets the flash with a notice of the event's update" do
              subject { flash[:notice] }
              it { should eq 'Event was successfully updated.' }
            end
          end
          describe 'with invalid params' do
            before do
              login_user regular_user
              put(
                :update,
                params: {
                  id: 'science-fiction-club',
                  event: invalid_attributes,
                  calendar_id: 'regular-calendar'
                }
              )
            end
            it_should_behave_like 'a successful page', which_renders: 'edit'

            describe 'loads the given event into @event' do
              subject { assigns(:event) }
              it { should eq science_fiction_club }
            end

            describe 'does not update @event' do
              subject { science_fiction_club.reload }
              its(:name) { should eq 'Science Fiction Club' }
            end

            describe "sets the flash with the event's errors" do
              subject { flash[:error] }
              it { should eq "Name can't be blank" }
            end
          end
        end
      end
    end

    describe 'DELETE #destroy' do
      describe 'when not logged in' do
        before do
          # Here's where we are *not* logging in
          delete(
            :destroy,
            params: {
              id: 'science-fiction-club',
              calendar_id: 'regular-calendar'
            }
          )
        end
        it_should_behave_like 'a redirect to the home page'
      end
      describe 'when logged in' do
        describe 'as someone other than the owner' do
          before do
            login_user other_user
            delete(
              :destroy,
              params: {
                id: 'science-fiction-club',
                calendar_id: 'regular-calendar'
              }
            )
          end
          it_should_behave_like 'a 403 Forbidden error'
        end
        describe 'as the owner' do
          before do
            login_user regular_user
            delete(
              :destroy,
              params: {
                id: 'science-fiction-club',
                calendar_id: 'regular-calendar'
              }
            )
          end
          # Note that slug does not change
          it_should_behave_like(
            'a redirect to',
            '/date_book/calendars/regular-calendar/events'
          )

          describe "sets the flash with a notice of the event's removal" do
            subject { flash[:notice] }
            it { should eq 'Event was successfully removed.' }
          end
        end
        describe 'as the owner, counting' do
          before do
            login_user regular_user
          end
          it 'results one less event' do
            expect do
              delete(
                :destroy,
                params: {
                  id: 'science-fiction-club',
                  calendar_id: 'regular-calendar'
                }
              )
            end.to change { Event.count(:id) }.by(-1)
          end
        end
      end
    end
  end
end
