function showPopover(element) {
}

function calendarEventRender(event, element) {

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