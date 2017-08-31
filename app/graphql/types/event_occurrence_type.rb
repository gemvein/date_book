# frozen_string_literal: true

Types::EventOccurrenceType = GraphQL::ObjectType.define do
  name 'EventOccurrences'
  description 'DateBook Event Occurrences'

  implements GraphQL::Relay::Node.interface
  # `id` exposes the UUID
  global_id_field :id

  field :id, !types.ID
  field :event, Types::EventType
  field :url, types.String
  field :popover_url, types.String
  field :start, types.String
  field :end, types.String
end
