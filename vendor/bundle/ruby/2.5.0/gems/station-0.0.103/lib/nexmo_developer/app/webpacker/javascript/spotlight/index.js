import Volta from "../volta/volta.js"

export default () => {
  $(document).ready(function() {
    $(document).on('ajax:success', '#spotlight-form', function(event, response) {
      Volta.flash.show('success');
      event.target.reset();
    }).on('ajax:error', '#spotlight-form', function(event) {
      Volta.flash.show('error');
    });
  });
}
