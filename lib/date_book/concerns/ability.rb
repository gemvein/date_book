# frozen_string_literal: true

module DateBook
  # DateBook Ability model
  module Ability
    include CanCan::Ability

    def initialize_date_book(user)
      alias_action :index, :show, :popover, to: :read

      can :read, Calendar
      can :read, Event

      unless user.new_record?
        my_calendar_ids = Calendar.with_role(:owner, user).ids
        my_event_ids = Event.with_role(:owner, user).ids
        can :create, Calendar
        can :manage, Calendar, id: my_calendar_ids
        can :manage, Event, calendar_id: my_calendar_ids
        can :manage, Event, id: my_event_ids
      end

      can :manage, :all if user.has_role? :admin
    end
  end
end
