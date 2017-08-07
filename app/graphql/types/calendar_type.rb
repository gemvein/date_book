Types::CalendarType = GraphQL::ObjectType.define do
  name "Calendar"
  description "DateBook Calendars"

  field :id, types.ID
  field :name, types.String
  field :slug, !types.String
  field :description, types.String
  field :css_class, types.String
  field :created_at, Types::DateTimeType
  field :updated_at, Types::DateTimeType
  field :events, types[Types::EventType]
  field :event_occurrences, types[Types::EventOccurrenceType]
end
