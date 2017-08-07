module DateBook
  module ActsAsCalendar
    def acts_as_calendar(options = {})
      acts_as_ownable

      validates_presence_of :name, :slug

      # FriendlyId Gem
      extend FriendlyId
      friendly_id :name, use: :slugged

      # Relationships
      has_many :events, dependent: :destroy

      include InstanceMethods
      extend ClassMethods
    end

    module InstanceMethods
    end

    module ClassMethods
    end

  end
end
