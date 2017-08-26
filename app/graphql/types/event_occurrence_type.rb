# frozen_string_literal: true

Types::EventOccurrenceType = GraphQL::ObjectType.define do
  name 'EventOccurrences'
  description 'DateBook Event Occurrences'

  field :id, !types.ID
  field :event, Types::EventType
  field :url, types.String
  field :popover_url, types.String
  field :start, types.String
  field :end, types.String
end
