export default class Format {
  constructor() {
    this.formatSelector = $('.js-format-selector')[0]
    if (this.formatSelector) {
      this.formatChanged(this.formatSelector.value, false)
      $(this.formatSelector).change((event) => this.formatChanged(event.target.value))

      this.restoreFormat()
    }
  }

  formatChanged(format, persist = true) {
    $('.js-format').hide()
    $(`.js-format[data-format='${format}']`).show()

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
        $(this.formatSelector).val(format)
        this.formatChanged(format, false)
      }
    }
  }
}
