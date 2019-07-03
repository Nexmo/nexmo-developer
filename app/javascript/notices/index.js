export default () => {
  const noticeCloseComplete = function(notice) {
    notice.remove()
    removeNoticesIfEmpty()
  }

  const noticeKey = function (notice) {
    const id = notice.data('notice-id')
    return `notice-dismissed(id:${id})`
  }

  const isDismissible = function (notice) {
    return notice.data('notice-dismissible')
  }

  const bootstrap = function() {
    $(document).on('click', '.notice a[data-close]', function(event) {
      const notice = $(this).parents('.notice')
      localStorage.setItem(noticeKey(notice), true)

      TweenLite.to(notice, 0.6, {
        scale: 0,
        height: 0,
        transformOrigin: "center top",
        ease: Power2.easeIn,
        onComplete: () => noticeCloseComplete(notice)
      });
    });
  }

  const removeNoticesIfEmpty = function() {
    if ($('.notices .notice').length === 0) {
      $('.notices').remove()
    }
  }

  const clearRead = function() {
    $('.notices .notice').each(function() {
      const notice = $(this)
      if(isDismissible(notice)) { return }
      if (localStorage.getItem(noticeKey(notice))) {
        $(this).remove()
      }
    })
    removeNoticesIfEmpty()
  }

  $(document).ready(function() {
    bootstrap()
    clearRead()
  });
}
