# frozen_string_literal: true

require 'rails_helper'

describe DateBook::ApplicationHelper, folder: :helpers do
  include_context 'loaded site'

  describe '#date_book_scripts' do
    subject { helper.date_book_scripts }
    it { should have_tag('script') }
    it { should have_tag('link') }
  end

  describe '#date_book_date_range' do
    let(:start_date) { Time.parse('2017-07-04 10:00 AM') }
    let(:end_date) { Time.parse('2017-07-05 10:00 AM') }
    subject { helper.date_book_date_range(start_date, end_date, false, 1.day) }
    it { should eq "2017-07-04 10:00 am\n&mdash;\n2017-07-05 10:00 am\n"}
  end

  describe '#date_book_date' do
    let(:date) { Time.parse('2017-07-04 10:00 AM') }
    subject { helper.date_book_date(date, false) }
    it { should eq "2017-07-04 10:00 am"}
  end

  describe '#date_book_time' do
    let(:time) { Time.parse('10:00 AM') }
    subject { helper.date_book_time(time) }
    it { should eq "10:00 am"}
  end
end
