# frozen_string_literal: true

module DateBook
  # DateBook Ability model
  module Ability
    include CanCan::Ability

    def initialize_date_book(user)
      alias_action :index, :show, :popover, to: :read
      if user.has_role? :admin
        can :manage, :all
      elsif user.new_record?
        can :read, Calendar
        can :read, Event do |event|
          can?(:read, event.calendar)
        end
      else
        can :read, Calendar
        can :read, Event
        cannot :create, Event
        can :manage, Calendar, id: Calendar.with_role(:owner, user).ids
        can :manage, Event, id: Event.with_role(:owner, user).ids
        can :manage, Event do |event|
          can?(:update, event.calendar)
        end
      end
    end
  end
end
