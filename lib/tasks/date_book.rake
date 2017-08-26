# frozen_string_literal: true
namespace :date_book do
  desc 'Dump GraphQL Schema'
  task dump_schema: :environment do
    # Get a string containing the definition in GraphQL IDL:
    schema_defn = DateBookSchema.to_definition
    # Choose a place to write the schema dump:
    schema_path = "public/date_book_schema.graphql"
    # Write the schema dump to that file:
    File.open(Rails.root.join(schema_path), 'w') { |f| f << schema_defn }
    puts "Updated #{schema_path}"
  end
end
