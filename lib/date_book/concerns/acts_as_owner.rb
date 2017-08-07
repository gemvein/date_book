module DateBook
  module ActsAsOwner
    def acts_as_owner(options = {})
      include InstanceMethods
      extend ClassMethods
    end

    module InstanceMethods
      def calendars
        Calendar.with_role(:owner, self)
      end
    end

    module ClassMethods
    end

  end
end
