class Format {
  constructor() {
    this.formatSelectors = document.getElementsByClassName('js-format-selector');

    if (this.formatSelectors.length) {
      this.formatChanged(this.formatSelectors[0].value, false)
      for (let selector of this.formatSelectors) {
        selector.addEventListener('change', (event) => {
          this.formatChanged(event.target.value)
        })
      }

      this.restoreFormat()
    }
  }

  formatChanged(format, persist = true) {
    for (var item of document.getElementsByClassName('js-format')) {
      item.hidden = true
    }
    for (var item of document.querySelectorAll(`.js-format[data-format='${format}']`)) {
      item.hidden = false
    }

    if (persist) {
      this.persistFormat(format)
    }
  }

  persistFormat(format) {
    if (window.localStorage) {
      window.localStorage.setItem('format', format)
    }
  }

  restoreFormat() {
    if (window.localStorage) {
      const format = window.localStorage.getItem('format')
      if (format) {
        for (let selector of this.formatSelectors) {
          selector.value = format
        }
        this.formatChanged(format, false)
      }
    }
  }
}
