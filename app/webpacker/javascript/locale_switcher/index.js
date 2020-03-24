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
      let dropdownBtn = self.switcher.querySelector('.Vlt-btn');
      let dropdownOptions = self.switcher.querySelectorAll('.Vlt-dropdown__link');

      dropdownOptions.forEach(function(option) {
        let value = option.innerText
        option.addEventListener("click", function() {
          dropdownBtn.innerHTML = option.innerHTML;
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
