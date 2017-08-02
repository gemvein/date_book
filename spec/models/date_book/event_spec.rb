require 'rails_helper'

RSpec.describe DateBook::Event, folder: :models do
  include_context 'loaded site'

  describe 'Model' do
    # Rolify Gem
    it { should have_many(:roles) }

    # Schedulable Gem
    it { should have_one(:schedule) }

    # Validations
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:slug) }

    # Nested Attributes
    it { should accept_nested_attributes_for :schedule }
  end

  describe 'Class' do
    subject { DateBook::Event }
    # FriendlyId Gem
    it { should respond_to(:friendly) }
  end

  describe 'Scopes and Methods' do
    describe '#ending_after' do
      subject { DateBook::Event.ending_after(Time.zone.now) }
      it { should include tomorrows_event }
      it { should_not include yesterdays_event }
    end
    describe '#starting_before' do
      subject { DateBook::Event.starting_before(Time.zone.now) }
      it { should include yesterdays_event }
      it { should_not include tomorrows_event }
    end
    describe '#to_list' do
      subject { DateBook::Event.all.to_list }
      its(:first) { should be_a ::OpenStruct }
      it { should have_at_least(3).items }
    end
    describe '.schedule' do
      describe 'with a new record' do
        subject { DateBook::Event.new }
        its(:schedule) { should be_a_new Schedule }
      end
      describe 'with a saved record' do
        subject { monday_event }
        its(:schedule) { should be_a Schedule }
        its(:schedule) { should_not be_a_new Schedule }
      end
    end
    describe '.next_occurrence' do
      subject { tomorrows_event.next_occurrence }
      its(:start_date) { should be > Time.now }
    end
    describe '.previous_occurrence' do
      subject { yesterdays_event.previous_occurrence }
      its(:end_date) { should be < Time.now }
    end
  end
end