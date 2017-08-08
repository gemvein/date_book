# frozen_string_literal: true

require 'rails_helper'

describe DateBook::EventsHelper, folder: :helpers do
  helper BootstrapForm::Helpers::Bootstrap
  helper BootstrapLeather::ApplicationHelper
  helper DateBook::ApplicationHelper

  include_context 'loaded site'

  let(:form_section) do
    form_section = nil
    object = [monday_event.calendar, monday_event]

    helper.bootstrap_form_for object do |f|
      f.fields_for :schedule do |g|
        form_section = g
      end
    end

    form_section
  end

  describe '#date_book_event_occurrence_dates' do
    let(:rendered) { helper.date_book_event_occurrence_dates(monday_event) }
    it 'displays dates in a dl' do
      expect(rendered).to have_tag('dl') do
        with_tag 'dt' do
          with_text 'Next Occurrence'
        end
        with_tag 'dd' do
          with_tag 'a', with: { href: monday_event.event_occurrences.first.url }
        end
      end
    end
  end

  describe '#date_book_rule_form_section' do
    let(:rendered) do
      helper.date_book_rule_form_section('singular', form_section)
    end
    it 'contains a date field' do
      expect(rendered).to have_tag(
        'div',
        with: { class: 'form-group date-book--date' }
      ) do
        with_tag 'label', with: { for: 'event_schedule_attributes_date' }
        with_tag 'div', with: { class: 'input-group' } do
          with_tag 'span', with: { class: 'glyphicon-calendar' }
          with_tag 'input', with: { id: 'event_schedule_attributes_date' }
        end
      end
    end
    it 'contains a time field' do
      expect(rendered).to have_tag(
        'div',
        with: { class: 'form-group date-book--time' }
      ) do
        with_tag 'label', with: { for: 'event_schedule_attributes_time' }
        with_tag 'div', with: { class: 'input-group' } do
          with_tag 'span', with: { class: 'glyphicon-time' }
          with_tag 'input', with: { id: 'event_schedule_attributes_time' }
          with_tag 'input', with: { id: 'event_schedule_attributes_all_day' }
        end
      end
    end
    it 'contains a duration field' do
      expect(rendered).to have_tag(
        'div',
        with: { class: 'form-group date-book--duration' }
      ) do
        with_tag 'label', with: { for: 'event_schedule_attributes_duration' }
        with_tag 'div', with: { class: 'input-group' } do
          with_tag 'input', with: {
            id: 'event_schedule_attributes_duration_attributes_count'
          }
          with_tag 'select', with: {
            id: 'event_schedule_attributes_duration_attributes_unit'
          }
        end
      end
    end
  end

  describe '#date_book_date_field' do
    let(:rendered) { helper.date_book_date_field(form_section) }
    it 'shows the date field' do
      expect(rendered).to have_tag(
        'div',
        with: { class: 'form-group date-book--date' }
      ) do
        with_tag 'label', with: { for: 'event_schedule_attributes_date' }
        with_tag 'div', with: { class: 'input-group' } do
          with_tag 'span', with: { class: 'glyphicon-calendar' }
          with_tag 'input', with: { id: 'event_schedule_attributes_date' }
        end
      end
    end
  end

  describe '#date_book_time_field' do
    let(:rendered) { helper.date_book_time_field(form_section) }
    it 'shows the time field' do
      expect(rendered).to have_tag(
        'div',
        with: { class: 'form-group date-book--time' }
      ) do
        with_tag 'label', with: { for: 'event_schedule_attributes_time' }
        with_tag 'div', with: { class: 'input-group' } do
          with_tag 'span', with: { class: 'glyphicon-time' }
          with_tag 'input', with: { id: 'event_schedule_attributes_time' }
          with_tag 'input', with: { id: 'event_schedule_attributes_all_day' }
        end
      end
    end
  end

  describe '#date_book_duration_field' do
    let(:rendered) { helper.date_book_duration_field(form_section) }
    it 'shows the duration field' do
      expect(rendered).to have_tag(
        'div',
        with: { class: 'form-group date-book--duration' }
      ) do
        with_tag 'label', with: { for: 'event_schedule_attributes_duration' }
        with_tag 'div', with: { class: 'input-group' } do
          with_tag 'input', with: {
            id: 'event_schedule_attributes_duration_attributes_count'
          }
          with_tag 'select', with: {
            id: 'event_schedule_attributes_duration_attributes_unit'
          }
        end
      end
    end
  end

  describe '#date_book_interval_field' do
    let(:rendered) { helper.date_book_interval_field('hours', form_section) }
    it 'shows the interval field' do
      expect(rendered).to have_tag('div', with: { class: 'form-group' }) do
        with_tag 'label', with: { for: 'event_schedule_attributes_interval' }
        with_tag 'input', with: { id: 'event_schedule_attributes_interval' }
      end
    end
  end

  describe '#date_book_day_field' do
    let(:rendered) { helper.date_book_day_field(form_section) }
    it 'shows a hidden field to catch destruction of all checks' do
      expect(rendered).to have_tag(
        'input',
        with: {
          type: 'hidden',
          id: 'event_schedule_attributes_day'
        }
      )
    end
    it 'shows the actual checkboxes' do
      expect(rendered).to have_tag(
        'div',
        with: { class: 'form-group date-book--day' }
      ) do
        with_tag 'label', minimum: 7 do
          with_tag 'input', with: { type: 'checkbox' }
        end
      end
    end
  end

  describe '#date_book_day_of_week_field' do
    let(:rendered) { helper.date_book_day_of_week_field(form_section) }
    it 'shows the day of week field' do
      expect(rendered).to have_tag(
        'div',
        with: { class: 'form-group date-book--day-of-week' }
      ) do
        with_tag 'td', count: 35 do
          with_tag 'input', with: { type: 'checkbox' }
        end
      end
    end
  end
end
