module DateBook
  module ActsAsEventOccurrence
    def acts_as_event_occurrence(options = {})
      before_save :set_end_date

      alias_attribute :start_date, :date

      belongs_to :schedulable, polymorphic: true
      alias_attribute :event, :schedulable
      delegate :schedule, to: :schedulable

      # Scopes
      scope :remaining, -> { where('date >= ?',Time.now) }
      scope :previous, -> { where('date < ?',Time.now) }
      scope :ending_after, -> (start_date) { (where 'end_date >= ?', start_date) }
      scope :starting_before, -> (end_date) { where 'date < ?', end_date }
      scope :for_events, -> { where(schedulable_type: 'Event') }
      scope :for_schedulables, -> (model_name, ids) { where(schedulable_type: model_name).where('schedulable_id IN (?)',  ids) }
      scope :ascending, -> { order date: :asc }
      scope :descending, -> { order date: :desc }

      include InstanceMethods
      extend ClassMethods
    end

    module InstanceMethods
      def url
        event.url(self)
      end

      def popover_url
        event.popover_url(self)
      end

      def start_moment
        if schedule.all_day
          I18n.localize date, format: :moment_date
        else
          I18n.localize date, format: :moment_datetime
        end
      end
      alias_method :start, :start_moment

      def end_moment
        if schedule.all_day
          I18n.localize end_date, format: :moment_date
        else
          I18n.localize end_date, format: :moment_datetime
        end
      end
      alias_method :end, :end_moment

      private

      def set_end_date
        self.end_date = date + schedulable.schedule.duration
      end
    end

    module ClassMethods
      def event_ids
        for_events.pluck(:schedulable_id).uniq
      end
    end

  end
end
