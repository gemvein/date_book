# frozen_string_literal: true

require 'rails_helper'
require 'cancan/matchers'

describe 'Abilities on Calendars', folder: :abilities do
  include_context 'loaded site'

  ####################
  # Abilities        #
  ####################
  context 'when anonymous' do
    let(:user) { nil }
    subject(:ability) { Ability.new(user) }
    it { should be_able_to(:index, regular_calendar) }
    it { should be_able_to(:show, regular_calendar) }
    it { should_not be_able_to(:manage, regular_calendar) }
    it { should_not be_able_to(:create, Calendar) }
  end
  context 'when logged in as regular user' do
    let(:user) { regular_user }
    subject(:ability) { Ability.new(user) }
    it { should be_able_to(:index, regular_calendar) }
    it { should be_able_to(:show, regular_calendar) }
    it { should be_able_to(:manage, regular_calendar) }
    it { should be_able_to(:create, Calendar) }
    it { should be_able_to(:index, other_calendar) }
    it { should be_able_to(:show, other_calendar) }
    it { should_not be_able_to(:manage, other_calendar) }
  end
  context 'when logged in as admin' do
    let(:user) { admin_user }
    subject(:ability) { Ability.new(user) }
    it { should be_able_to(:index, regular_calendar) }
    it { should be_able_to(:show, regular_calendar) }
    it { should be_able_to(:manage, regular_calendar) }
    it { should be_able_to(:create, Calendar) }
  end
end
