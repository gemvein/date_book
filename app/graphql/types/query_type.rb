# frozen_string_literal: true

# This defines the top-level queries that are available.
# rubocop:disable Metrics/BlockLength
Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'
  # Used by Relay to lookup objects by UUID:
  field :node, GraphQL::Relay::Node.field

  # Fetches a list of objects given a list of IDs
  field :nodes, GraphQL::Relay::Node.plural_field

  # Add root-level fields here.
  # They will be entry points for queries on your schema.
  field :event_occurrences do
    type types[Types::EventOccurrenceType]
    description 'Find all event occurrences in range'
    argument :ending_after, types.String # Start date
    argument :starting_before, types.String # End date
    resolve(lambda do |_obj, args, ctx|
      Event
        .readable_by(ctx[:current_user])
        .as_occurrences
        .starting_before(args[:starting_before]&.to_datetime)
        .ending_after(args[:ending_after]&.to_datetime)
    end)
  end

  field :calendar do
    type Types::CalendarType
    description 'Find a calendar by slug'
    argument :slug, types.String
    resolve(lambda do |_obj, args, ctx|
      Calendar
        .readable_by(ctx[:current_user])
        .friendly
        .find(args[:slug])
    end)
  end
end
# rubocop:enable Metrics/BlockLength
