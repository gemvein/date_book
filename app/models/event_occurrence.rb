class EventOccurrence < ActiveRecord::Base
  before_save :set_end_date

  alias_attribute :start_date, :date

  belongs_to :schedulable, polymorphic: true
  delegate :schedule, to: :schedulable

  default_scope { ascending }
  scope :remaining, -> { where('date >= ?',Time.now) }
  scope :previous, -> { where('date < ?',Time.now) }

  scope :ending_after, -> (start_date) { (where 'end_date >= ?', start_date) }
  scope :starting_before, -> (end_date) { where 'date < ?', end_date }
  scope :for_events, -> { where(schedulable_type: 'DateBook::Event') }
  scope :for_schedulables, -> (model_name, ids) { where(schedulable_type: model_name).where('schedulable_id IN (?)',  ids) }
  scope :ascending, -> { order date: :asc }
  scope :descending, -> { order date: :desc }

  def self.event_ids
    for_events.pluck(:schedulable_id)
  end

  def start_moment
    if schedule.all_day
      date&.strftime('%F')
    else
      date&.strftime('%FT%T')
    end
  end

  def end_moment
    if schedule.all_day
      end_date&.strftime('%F')
    else
      end_date&.strftime('%FT%T')
    end
  end

  private

  def set_end_date
    self.end_date = date + schedulable.schedule.duration
  end
end
