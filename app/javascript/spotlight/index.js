export default () => {
  $(document).ready(function() {
    Volta.flash.init();

    $(document).on('ajax:success', '#spotlight-form', function(event, response) {
      Volta.flash.show('success');
    }).on('ajax:error', '#spotlight-form', function(event) {
      Volta.flash.show('error');
    });
  });
}
