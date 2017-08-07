# frozen_string_literal: true

require 'rails_helper'
require 'cancan/matchers'

describe 'Abilities on Events', folder: :abilities do
  include_context 'loaded site'

  ####################
  # Abilities        #
  ####################
  context 'when anonymous' do
    let(:event) { monday_event }
    let(:user) { nil }
    subject(:ability) { Ability.new(user) }
    it { should be_able_to(:index, event) }
    it { should be_able_to(:show, event) }
    it { should_not be_able_to(:manage, event) }
    it { should_not be_able_to(:create, Event) }
  end
  context 'when logged in as regular user' do
    let(:my_event) { science_fiction_club_event }
    let(:other_event) { monday_event }
    let(:user) { regular_user }
    subject(:ability) { Ability.new(user) }
    it { should be_able_to(:index, my_event) }
    it { should be_able_to(:show, my_event) }
    it { should be_able_to(:manage, my_event) }
    it { should be_able_to(:create, regular_calendar.events.new) }
    it { should be_able_to(:index, other_event) }
    it { should be_able_to(:show, other_e9bvent) }
    it { should_not be_able_to(:manage, other_event) }
    it { should_not be_able_to(:create, other_calendar.events.new) }
  end
  context 'when logged in as admin' do
    let(:event) { monday_event }
    let(:user) { admin_user }
    subject(:ability) { Ability.new(user) }
    it { should be_able_to(:index, event) }
    it { should be_able_to(:show, event) }
    it { should be_able_to(:manage, event) }
    it { should be_able_to(:create, Event) }
  end
end
