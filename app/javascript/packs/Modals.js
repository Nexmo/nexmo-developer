import { Foundation } from 'foundation-sites/js/foundation.core';
import { Reveal } from 'foundation-sites/js/foundation.reveal';

export default () => {
  Foundation.addToJquery($);
  Foundation.plugin(Reveal, 'Reveal');
  $(document).foundation()
}
