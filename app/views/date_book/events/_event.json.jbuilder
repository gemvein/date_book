json.id event.id
json.slug event.slug
json.url date_book.event_path(event.slug)
json.title event.title
json.description event.description
json.editable can?(:edit, event).to_s
json.className event.css_class
json.start event.start_moment
json.end event.end_moment
json.duration event.duration
json.allDay event.all_day