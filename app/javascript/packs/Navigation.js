window.navigationAnimationInProgress = false;
let animationSpeed = 0.2;

let init = function(animate){
  if (animate == null) { animate = false; }
  $('.js-navigation > li > ul').each(function() {
    if ($(this).find('.active').length === 0) {
      TweenLite.set($(this), { height: 0 });
    } else {
      $(this).addClass('expanded');
      $(this).find('a.active').first().closest('.js--collapsible').siblings().find('ul').hide();

      let height = $(this).height();
      $(this).data('height', height);
      if (animate) { TweenLite.fromTo($(this), animationSpeed, { height: 0 }, { height }); }
    }
  });

  $('.js-navigation > li').click(function(event) {
    if ($(event.target).parents('.expanded').length === 0) {
      window.animateNavigationOnLoadIn = true;
      window.navigationAnimationInProgress = true;
      TweenLite.to($('.js-navigation .expanded'), animationSpeed, { height: 0, onComplete: navigationAnimationComplete });
    } else {
      window.animateNavigationOnLoadIn = false;
    }
    return true;
  });

  $('.js-navigation > a').click(() => TweenLite.to($('.js-navigation .expanded'), animationSpeed, { height: 0, onComplete: navigationAnimationComplete }));
};

let injectFutureNavigation = function() {
  if (window.futureNavigation && !window.navigationAnimationInProgress) {
    $('.js-navigation').html(window.futureNavigation);
    window.futureNavigation = undefined;
    init(window.animateNavigationOnLoadIn);
  }
};

var navigationAnimationComplete = function() {
  window.navigationAnimationInProgress = false;
  injectFutureNavigation();
};

export default () => {
  $(document).ready(() => init());

  $(document).on('turbolinks:before-render', (event) => {
    window.futureNavigation = $(event.originalEvent.data.newBody).find('.js-navigation').html()
  });

  $(document).on('turbolinks:load', () => injectFutureNavigation());
}
