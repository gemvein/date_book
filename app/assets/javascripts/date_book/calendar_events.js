function calendarEventRender(event, element) {
    element.on('click', function (e) {
        e.preventDefault();
    });
    element.popover({
        html: true,
        placement: 'auto',
        viewport: '.calendar',
        container: 'body',
        title: '<a href="' + event.url + '">' + event.title + '</a><span onclick="hideParentPopover(this);" class="float-right glyphicon glyphicon-remove"></span>',
        content: event.popover,
    });
}

var calendarEventHeader = {
    left: 'today',
    center: 'prevYear,prev title next,nextYear',
    right: 'month,agendaWeek,agendaDay'
}