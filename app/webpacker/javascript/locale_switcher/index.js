import Rails from '@rails/ujs';

export default class LocaleSwitcher {
  constructor() {
    this.switcher = document.getElementById('locale-switcher');
    this.setupEventListeners();
  }

  setupEventListeners() {
    const self = this;

    window.addEventListener('load', function() {
      self.switcher.addEventListener('change', self.localeChangeHandler.bind(self));
    });
  }

  localeChangeHandler() {
    Rails.ajax({
      url: "/set_user_locale",
      type: "PUT",
      dataType: 'json',
      data: `preferred_locale=${this.switcher.value}`
    })
  }
}
