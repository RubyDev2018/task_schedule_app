$(document).on('turbolinks:load', function() {
  $('#calendar').fullCalendar({
    events: 'calendar.json',
  });
});
