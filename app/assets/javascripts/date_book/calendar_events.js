function calendarBySlugQuery(slug) {
  // GraphQL requires double-quoted strings in the query:
  return (' { calendar(slug: "' + slug + '") { event_occurrences { url, popover_url, start, end, event {id, name, all_day, calendar { css_class, text_color, background_color, border_color } } } } } ')
}

function calendarEventsQuery(slug) {
  // GraphQL requires double-quoted strings in the query:
  return (' { event_occurrences { url, popover_url, start, end, event {id, name, all_day, calendar { css_class, text_color, background_color, border_color } } } } ')
}

function formatEventOccurrence(occurrence) {
  event = occurrence.event
  if (event.css_class == null) {
    className = ''
  } else {
    className = event.css_class
  }
  if (event.all_day == true) {
    className = className + ' all-day'
  } else {
    className = className + ' part-day'
  }
  return ({
    id: event.id,
    title: event.name,
    description: event.description,
    className: className,
    textColor: event.calendar.text_color,
    backgroundColor: event.calendar.background_color,
    borderColor: event.calendar.border_color,
    allDay: event.all_day,
    url: occurrence.url,
    popover_url: occurrence.popover_url,
    start: occurrence.start,
    end: occurrence.end
  })
}

function calendarEventRender(event, element) {
  element.on('click', function (e) {
    e.preventDefault()
    $.get(event.popover_url, function (ajax_data) {
      element.popover({
        html: true,
        placement: 'auto',
        viewport: '.date-book--calendar',
        container: 'body',
        title: '<a href="' + event.url + '">' + event.title + '</a><span onclick="hideParentPopover(this);" class="float-right glyphicon glyphicon-remove"></span>',
        content: ajax_data
      }).popover('show')
    })
  })

}

var calendarEventHeader = {
  left: 'today',
  center: 'prevYear,prev title next,nextYear',
  right: 'month,agendaWeek,agendaDay'
}