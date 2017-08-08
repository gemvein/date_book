# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Calendar, folder: :models do
  include_context 'loaded site'

  describe 'Model' do
    # Rolify Gem
    it { should have_many(:roles) }

    # Validations
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:slug) }

    # Relationships
    it { should have_many(:events) }
  end

  describe 'Class' do
    subject { Calendar }
    # FriendlyId Gem
    it { should respond_to(:friendly) }
  end

  describe 'Scopes and Methods' do
  end
end
