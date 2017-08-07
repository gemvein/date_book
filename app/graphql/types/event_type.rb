Types::EventType = GraphQL::ObjectType.define do
  name "Event"
  description "DateBook Events"

  field :id, !types.ID
  field :name, types.String
  field :slug, types.String
  field :description, types.String
  field :css_class, types.String
  field :created_at, Types::DateTimeType
  field :updated_at, Types::DateTimeType
end
