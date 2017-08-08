# frozen_string_literal: true

Types::ProfileType = GraphQL::ObjectType.define do
  name 'Profile'
  field :id, types.ID
  field :name, types.String
  field :email, types.String
  field :calendars, types[Types::CalendarType]
end
