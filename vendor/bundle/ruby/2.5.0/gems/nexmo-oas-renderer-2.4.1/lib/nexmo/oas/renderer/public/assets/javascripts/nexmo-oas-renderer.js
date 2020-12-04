document.addEventListener("DOMContentLoaded", function() {
  // Only run this JS on OAS pages
  if(!document.querySelector(".oas-wrapper")){
    return;
  }

  if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
    var queryString = new URLSearchParams(window.location.search);
    if (!queryString.get('theme')) {
      queryString.set("theme", "dark");
      window.location.search = queryString.toString();
    }
  }

  // Handle people clicking on oneOf tabs by changing every one on the page
  var oneOfTabs = document.querySelectorAll('[data-tab-link]');
  Array.from(oneOfTabs).forEach(function (element) {
    element.addEventListener('click', function (event) {
      var link = event.target.getAttribute('data-tab-link');
      var matchingTabs = document.querySelectorAll('[data-tab-link="' + link + '"]');
      Array.from(matchingTabs).forEach(function (element) {
        element.dispatchEvent(new Event('toggle'));

        // Switch anything that's in a dropdown
        if (element.parentNode.className.indexOf("Vlt-dropdown__panel__content") !== -1) {
          // This is *very* structure dependent, but also the most compatible way to handle it
          var panel = element.parentNode.parentNode;
          var titleNodes = Array.from(panel.previousSibling.previousSibling.firstChild.childNodes);
          titleNodes[1].textContent = element.textContent;
        }
      });
    });
  });

  var toggleTopNav = function(event, closeOnly) {

    if (event) {
      if (!Array.from(event.target.classList).includes("oas-trigger")) {
        return;
      }
    }

    var c = document.querySelector('.oas-trigger-content');
    if (closeOnly === true) {
      c.style.display = "none";
      return;
    }
    c.style.display = c.style.display == 'block' ? 'none' : "block";
  };

  if (document.querySelector('.oas-trigger')) {
    document.querySelector('.oas-trigger').addEventListener("click", toggleTopNav);
  }

  document.querySelectorAll('a').forEach((element) => {
    var href = element.getAttribute("href");
    if (!href){ return; }
    if (href.slice(0,1) !== "#"){ return; }
    element.addEventListener('click', function (event) {
      event.preventDefault();

      toggleTopNav(null, true);

      var to = document.querySelector(event.target.hash)
      history.pushState({}, '', event.target.href);
      window.scrollTo({
        top: (window.scrollY + to.getBoundingClientRect().y) - 70,
        left: 0,
      })


    });
  });
});

