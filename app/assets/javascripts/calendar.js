$(document).on('turbolinks:load', function() {
  $('#calendar').fullCalendar({
    events: 'calendar.json',
    //ボタンのレイアウト
    // ヘッダーのタイトルとボタン
    header: {
        // title, prev, next, prevYear, nextYear, today
        left: 'prev,next today',
        center: 'title',
        right: 'month agendaWeek agendaDay'
    },
    //イベントの時間表示を２４時間に
    timeFormat: "HH:mm",
    //イベントの色を変える
    eventColor: '#ffc107',
    //イベントの文字色を変える
    eventTextColor: '#000000',
  });
});
