# frozen_string_literal: true

require 'rails_helper'

module DateBook
  RSpec.describe CalendarsController, folder: :controllers do
    routes { DateBook::Engine.routes }

    include_context 'loaded site'
    include ControllerMacros

    # This should return the minimal set of attributes required to create a valid
    # Calendar. As you add validations to Calendar, be sure to
    # adjust the attributes here as well.
    let(:valid_attributes) do
      { name: 'Test Calendar', schedule_attributes: { date: 1.hour.ago.to_date, time: 1.hour.ago } }
    end

    let(:invalid_attributes) do
      { name: nil, schedule_attributes: nil }
    end

    describe 'GET #index' do
      before do
        get :index, params: {}
      end
      it_should_behave_like 'a successful page', which_renders: 'index'

      describe 'loads calendars into @calendars' do
        subject { assigns(:calendars) }
        it { should include regular_calendar }
        it { should include other_calendar }
        it { should include admin_calendar }
      end
    end

    describe 'GET #show' do
      before do
        get :show, params: { id: 'regular-calendar' }
      end
      it_should_behave_like 'a successful page', which_renders: 'show'
    end

    describe 'GET #new' do
      describe 'when not logged in' do
        before do
          # Here's where we are *not* logging in
          get :new
        end
        it_should_behave_like 'a redirect to the home page'
      end
      describe 'when logged in' do
        before do
          login_user regular_user
          get :new
        end
        it_should_behave_like 'a successful page', which_renders: 'new'

        describe 'loads a new calendar into @calendar' do
          subject { assigns(:calendar) }
          it { should be_a_new Calendar }
        end
      end
    end

    describe 'GET #edit' do
      describe 'when not logged in' do
        before do
          # Here's where we are *not* logging in
          get :edit, params: { id: 'regular-calendar' }
        end
        it_should_behave_like 'a redirect to the home page'
      end
      describe 'when logged in' do
        describe 'as someone other than the owner' do
          before do
            login_user other_user
            get :edit, params: { id: 'regular-calendar' }
          end
          it_should_behave_like 'a 403 Forbidden error'
        end
        describe 'as the owner' do
          before do
            login_user regular_user
            get :edit, params: { id: 'regular-calendar' }
          end
          it_should_behave_like 'a successful page', which_renders: 'edit'

          describe 'loads requested calendar into @calendar' do
            subject { assigns(:calendar) }
            it { should eq regular_calendar }
          end
        end
      end
    end

    describe 'POST #create' do
      describe 'when not logged in' do
        before do
          # Here's where we are *not* logging in
          post :create, params: { calendar: valid_attributes }
        end
        it_should_behave_like 'a redirect to the home page'
      end
      describe 'when logged in' do
        describe 'with valid params' do
          before do
            login_user regular_user
            post :create, params: { calendar: valid_attributes }
          end
          it_should_behave_like(
            'a redirect to',
            '/date_book/calendars/test-calendar'
          )
          describe "sets the flash with a notice of the calendar's creation" do
            subject { flash[:notice] }
            it { should eq 'Calendar was successfully created.' }
          end
        end
        describe 'with valid params, counting' do
          before do
            login_user regular_user
          end
          it 'results in a new calendar' do
            expect { post(:create, params: { calendar: valid_attributes }) }
              .to change { Calendar.count(:id) }.by(1)
          end
        end
        describe 'with invalid params' do
          before do
            login_user regular_user
            post :create, params: { calendar: invalid_attributes }
          end
          it_should_behave_like 'a successful page', which_renders: 'new'

          describe "sets the flash with the calendar's errors" do
            subject { flash[:error] }
            it { should eq "Name can't be blank" }
          end
        end
        describe 'with invalid params, counting' do
          before do
            login_user regular_user
          end
          it 'does not result in a new calendar' do
            expect { post(:create, params: { calendar: invalid_attributes }) }
              .to_not change { Calendar.count(:id) }
          end
        end
      end
    end

    describe 'PUT #update' do
      describe 'when not logged in' do
        before do
          # Here's where we are *not* logging in
          put :update, params: { id: 'regular-calendar', calendar: valid_attributes }
        end
        it_should_behave_like 'a redirect to the home page'
      end
      describe 'when logged in' do
        describe 'as someone other than the owner' do
          before do
            login_user other_user
            put :update, params: { id: 'regular-calendar', calendar: valid_attributes }
          end
          it_should_behave_like 'a 403 Forbidden error'
        end
        describe 'as the owner' do
          describe 'with valid params' do
            before do
              login_user regular_user
              put :update, params: { id: 'regular-calendar', calendar: valid_attributes }
            end
            # Note that slug does not change
            it_should_behave_like 'a redirect to', '/date_book/calendars/regular-calendar'

            describe 'updates @calendar' do
              subject { regular_calendar.reload }
              its(:name) { should eq 'Test Calendar' }
            end

            describe "sets the flash with a notice of the calendar's update" do
              subject { flash[:notice] }
              it { should eq 'Calendar was successfully updated.' }
            end
          end
          describe 'with invalid params' do
            before do
              login_user regular_user
              put(
                :update, params: {
                  id: 'regular-calendar',
                  calendar: invalid_attributes
                }
              )
            end
            it_should_behave_like 'a successful page', which_renders: 'edit'

            describe 'loads the given calendar into @calendar' do
              subject { assigns(:calendar) }
              it { should eq regular_calendar }
            end

            describe 'does not update @calendar' do
              subject { regular_calendar.reload }
              its(:name) { should eq 'Regular Calendar' }
            end

            describe "sets the flash with the calendar's errors" do
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
          delete :destroy, params: { id: 'regular-calendar' }
        end
        it_should_behave_like 'a redirect to the home page'
      end
      describe 'when logged in' do
        describe 'as someone other than the owner' do
          before do
            login_user other_user
            delete :destroy, params: { id: 'regular-calendar' }
          end
          it_should_behave_like 'a 403 Forbidden error'
        end
        describe 'as the owner' do
          before do
            login_user regular_user
            delete :destroy, params: { id: 'regular-calendar' }
          end
          # Note that slug does not change
          it_should_behave_like 'a redirect to', '/date_book/calendars'

          describe "sets the flash with a notice of the calendar's removal" do
            subject { flash[:notice] }
            it { should eq 'Calendar was successfully removed.' }
          end
        end
        describe 'as the owner, counting' do
          before do
            login_user regular_user
          end
          it 'results one less calendar' do
            expect { delete(:destroy, params: { id: 'regular-calendar' }) }
              .to change { Calendar.count(:id) }.by(-1)
          end
        end
      end
    end
  end
end
