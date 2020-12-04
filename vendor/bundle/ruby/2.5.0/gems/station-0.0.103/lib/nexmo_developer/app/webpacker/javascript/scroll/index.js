export default () => {
  $(document).ready(function(){
    const $body = $('.Vlt-main');
    const nav = $('.Nxd-header');
    const codeNav = $('.Nxd-api__code__header');

    $body.on('scroll', function(){
      var scrollTop = $body.scrollTop();

      //navigation
      if (scrollTop > 50) {
        nav.addClass('Nxd-scroll-minify');
      } else {
        nav.removeClass('Nxd-scroll-minify');
      }

      //api code
      if (scrollTop > 70 && codeNav.length > 0) {
        codeNav.addClass('Nxd-api__code__header--sticky');
      } else if(codeNav.length > 0) {
        codeNav.removeClass('Nxd-api__code__header--sticky');
      }
    });
  })
}
