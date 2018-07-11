import throttle from 'lodash/throttle'

let onScrollOrResize = function() {
  let currentPosition = $(document).scrollTop();
  let delta = currentPosition + 20;
  let $activeHeading = undefined;

  $('#primary-content').find('h1,h2,h3,h4,h5,h6').each(function() {
    let $heading = $(this);
    let headingOffset = $heading.offset().top;

    if (headingOffset > delta) { return false; }
    return $activeHeading = $heading;
  });

  if ($activeHeading && ($activeHeading.length > 0)) {
    let scrollSpyId = $activeHeading.data('id');
    let $nextHeading = $(`.js-scrollspy a[data-scrollspy-id='${scrollSpyId}']`);

    if ($nextHeading.length === 0) {
      let id = $activeHeading.attr('id');
      $nextHeading = $(`.js-scrollspy a[href='#${id}']`);
    }

    if ($nextHeading.length > 0) {
      $(".js-scrollspy .active").removeClass('active');
      return $nextHeading.addClass('active');
    }
  }
};

export default () => {
  $(document).ready(function() {
    let onScrollOrResizeThrottled = throttle(onScrollOrResize, 20);
    $(document).scroll(onScrollOrResizeThrottled);
    $(document).resize(onScrollOrResizeThrottled);

    // Reset sidenav
    $('.navigation').siblings('div').remove()
    $('.navigation').removeAttr('style')

    // $('.navigation').scrollToFixed({
    //   marginTop: 20,
    //   minWidth: 575,
    //   limit: () => {
    //     return $('#footer').offset().top - $('.navigation').outerHeight(true) - 20
    //   }
    // });

    $('.slate-layout-code > .tabs').scrollToFixed()
    const formatMargin = $('.slate-layout-code > .tabs').children().length > 0 ? 60 : 20
    $('.slate-layout-code > .js-format-selector').scrollToFixed({ marginTop: formatMargin })
  });

}
