$(document).ready(function() {
  // Character count on a new tip's textarea
  $("#char-count").text(140 - $("#tip_body").val().length);
  $("#tip_body").keypress(function(e) {
    $("#char-count").text(140 - $(this).val().length);
  });

  // prompt before deleting a tip
  $('.delete').click(function() {
    var answer = confirm('Are you sure you want to delete this tip?');
    return answer;
  });
});
