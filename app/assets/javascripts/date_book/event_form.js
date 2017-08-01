$(function (){
    var rules = $('.event-schedule-rule');
    var sections = $('.event-schedule-rule-section');
    rules.on('change', function (e){
        console.log(this.value);
        form_section = $('#' + this.value + '-section');
        // Hide all rules
        sections.addClass('hide');
        // Show only the relevant rule
        form_section.removeClass('hide');
    });

    $('.date-picker').datepicker({
        dateFormat: 'yy-mm-dd'
    });
});