var triggerCallCount = 1

function trigger() {
  if (triggerCallCount === 1) {
    triggerCallCount = 0
    $(document).trigger('nexmo:load');
  } else {
    triggerCallCount++
  }
}

export function preventSamePage() {
  $(document).on('turbolinks:click', function(event) {
    if (event.target.getAttribute('href').charAt(0) === '#') {
      event.preventDefault();
    }

    if (event.target.getAttribute('href') === window.location.pathname) {
      return event.preventDefault();
    }
  });
}

export function animate() {
  var contentAnimationComplete = () => {
    window.contentAnimationInProgress = false;
    injectFutureContent();
  };

  var injectFutureContent = () => {
    if (window.futureContent && !window.contentAnimationInProgress) {
      $('#primary-content').html(window.futureContent);

      // reset
      window.futureContent = undefined
      TweenLite.fromTo($('#primary-content'), 0.3, { alpha: 0 }, { alpha: 1 });
    }

    trigger()
  };

  $(document).on('turbolinks:visit', (event) => {
    window.contentAnimationInProgress = true;
    TweenLite.fromTo($('#primary-content'), 0.2, { alpha: 1 }, {
      alpha: 0,
      onComplete: contentAnimationComplete,
    });
  });

  $(document).on('turbolinks:before-render', (event) => {
   window.futureContent = $(event.originalEvent.data.newBody).find('#primary-content').html()
  });

  $(document).on('turbolinks:load', (event) => {
    injectFutureContent()
  });
}
