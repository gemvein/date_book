function showRelevantSection (){
    active_rule = $('input.event-schedule-rule:checked').first();
    value = active_rule.val();
    $('.event-schedule-rule-section').html(sections[value]);
}


$(function (){
    var rules = $('.event-schedule-rule');
    rules.on('change', function (e){
        showRelevantSection();
    }).trigger('change');

    $('.input-group .all-day').on('change', function(){
        associated_time = $(this).parents('.input-group').find('.time-picker');
        if ($(this).is(':checked') == true) {
            associated_time.prop('disabled', true);
            associated_time.val('');
        } else {
            associated_time.prop('disabled', false);
        }
    });

    $('.date-picker').datetimepicker({
        format: 'YYYY-MM-DD'
    });

    $('.time-picker').datetimepicker({
        format: 'LT'
    });
});