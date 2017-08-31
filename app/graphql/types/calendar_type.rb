# frozen_string_literal: true

Types::CalendarType = GraphQL::ObjectType.define do
  interfaces [GraphQL::Relay::Node.interface]

  name 'Calendar'
  description 'DateBook Calendars'
  # `id` exposes the UUID
  global_id_field :id

  field :name, types.String
  field :slug, !types.String
  field :description, types.String
  field :css_class, types.String
  field :text_color, types.String
  field :background_color, types.String
  field :border_color, types.String
  field :created_at, Types::DateTimeType
  field :updated_at, Types::DateTimeType
  field :events, types[Types::EventType]
  field :event_occurrences, types[Types::EventOccurrenceType]
end
