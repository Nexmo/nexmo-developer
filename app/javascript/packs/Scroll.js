export default () => {
  $(document).ready(function(){
    const smoothScroll = new SmoothScroll('a[href^="#"]', {
      offset: 10,
    })

    if(window.location.hash) {
      const anchor = document.querySelector(window.location.hash);
      if (anchor) {
         smoothScroll.animateScroll(anchor, undefined, { offset: 40 });
      }
    }
  })
}
