export default () => {
  $(document).on('click', '.js-collapsible', function() {
    const $element = $(this)
    const id = $element.data('collapsible-id')
    
    if ($element.hasClass('collapsible')) {
      $element.toggleClass('collapsible--active')
    } else {
      $element.parent('.collapsible').toggleClass('collapsible--active')
    }

    $(`#${id}`).toggle()
  })
}
