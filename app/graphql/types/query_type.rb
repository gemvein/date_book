# frozen_string_literal: true

Types::QueryType = GraphQL::ObjectType.define do
  name 'Date Book API'
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  # Current user hack // Check GraphQL controller
  field :profile do
    type Types::ProfileType
    description 'Current signed in User'
    resolve ->(_obj, _args, ctx) { ctx[:current_user] || User.new }
  end

  field :event_occurrences do
    type types[Types::EventOccurrenceType]
    description 'Find all event occurrences in range'
    argument :ending_after, types.String # Start date
    argument :starting_before, types.String # End date
    resolve lambda do |_obj, args, ctx|
      ending_after = (
      args[:ending_after]&.to_datetime ||
        Time.now.beginning_of_month
      )
      starting_before = (
      args[:starting_before]&.to_datetime ||
        Time.now.beginning_of_month.next_month
      )
      Event
        .readable_by(ctx[:current_user])
        .as_occurrences
        .starting_before(starting_before)
        .ending_after(ending_after)
    end
  end

  field :calendar do
    type Types::CalendarType
    description 'Find a calendar by slug'
    argument :slug, types.String
    resolve lambda do |_obj, args, ctx|
      Calendar
        .readable_by(ctx[:current_user])
        .friendly
        .find(args[:slug])
    end
  end

  field :user do
    type Types::ProfileType
    description 'Find user by name'
    argument :name, types.String
    resolve ->(_obj, args, _ctx) { User.find_by_name(args[:name]) }
  end
end
