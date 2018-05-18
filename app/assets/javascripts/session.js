$(document).ready(function () {
  $('#sign-in').on('click', function () {
    var $this = $(this);

    $this.addClass('disabled');
    $this.find('i').removeClass('d-none');
  });
});
