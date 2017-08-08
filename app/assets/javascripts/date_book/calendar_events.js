function calendarBySlugQuery(slug) {
    // GraphQL requires double-quoted strings in the query:
    return(' { calendar(slug: "' + slug + '") { event_occurrences { url, start, end, event {id, name, description, css_class, all_day} } } } ');
}

function calendarEventsQuery(slug) {
    // GraphQL requires double-quoted strings in the query:
    return(' { event_occurrences { url, start, end, event {id, name, description, css_class, all_day} } } ');
}

function formatEventOccurrence(occurrence) {
    event = occurrence.event;
    if(event.css_class == null) {
        className = '';
    } else {
        className = event.css_class;
    }
    if(event.all_day == true) {
        className = className + ' all-day';
    } else {
        className = className + ' part-day';
    }
    return({
        id: event.id,
        title: event.name,
        description: event.description,
        className: className,
        allDay: event.all_day,
        url: occurrence.url,
        start: occurrence.start,
        end: occurrence.end
    });
}

function calendarEventRender(event, element) {
    console.log(event);
    element.on('click', function (e){
        e.preventDefault();
        $.get(event.popover_url, function(ajax_data) {
            element.popover({
                html: true,
                placement: 'auto',
                viewport: '.calendar',
                container: 'body',
                title: '<a href="' + event.url + '">' + event.title + '</a><span onclick="hideParentPopover(this);" class="float-right glyphicon glyphicon-remove"></span>',
                content: ajax_data
            }).popover('show');
        });
    });

}

var calendarEventHeader = {
    left: 'today',
    center: 'prevYear,prev title next,nextYear',
    right: 'month,agendaWeek,agendaDay'
}