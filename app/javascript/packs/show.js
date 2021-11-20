$(document).ready(function() {
  $('#time_in').on('change', function() {
    var $form = $(this).closest('form');
    $form.find('input[type=submit]').click();
  });
});

$(document).ready(function() {
  $('#date_work_date_work').on('change', function() {
    var $form = $(this).closest('form');
    $form.find('input[type=submit]').click();
  });
});
