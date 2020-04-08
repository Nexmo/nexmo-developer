import Rails from '@rails/ujs';

export default class LocaleSwitcher {
  constructor() {
    this.switcher = document.getElementById('locale-switcher');
    if (this.switcher) {
      this.setupEventListeners();
    }
  }

  setupEventListeners() {
    const self = this;

    window.addEventListener('load', function() {
      let dropdownBtn = self.switcher.querySelector('.Nxd-locale');
      let dropdownOptions = self.switcher.querySelectorAll('.Vlt-dropdown__link');
      let pannel = self.switcher.querySelector('.Vlt-dropdown__panel');

      dropdownOptions.forEach(function(option) {
        option.addEventListener("click", function(event) {
          event.stopPropagation();

          dropdownBtn.innerHTML = option.innerHTML;

          pannel.hidden = true;
          self.localeChangeHandler(option.dataset.locale);
        });
      });
    });
  }

  localeChangeHandler(locale) {
    Rails.ajax({
      url: "/set_user_locale",
      type: "PUT",
      dataType: 'json',
      data: `preferred_locale=${locale}`
    })
  }
}
