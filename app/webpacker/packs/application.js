/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import '@babel/polyfill'
import '@vonagevolta/volta2/js/addons/prism'

import '../stylesheets/application'

require.context('@vonagevolta/volta2/images/logos', true)
require.context('@vonagevolta/volta2/dist/symbol', true)

// XXX: hack for Volta, unfortunately it doesn't provide modules :(
import Volta from "../javascript/volta/volta.js"
import Rails from '@rails/ujs';

import Vue from 'vue/dist/vue.esm'

import { TweenLite, CSSPlugin } from 'gsap'
import GithubCards from '../javascript/github_cards'
import VoltaTabbedExamples from '../javascript/volta_tabbed_examples'
import Format from '../javascript/format'
import Scroll from '../javascript/scroll'
import Spotlight from '../javascript/spotlight'
import Notices from '../javascript/notices'
import Feedback from '../javascript/components/feedback/Feedback.vue'
import JwtGenerator from '../javascript/components/jwt_generator/JwtGenerator.vue'
import Search from '../javascript/components/search/Search.vue'
import Concatenation from '../javascript/components/concatenation/Concatenation.vue'
import APIStatus from '../javascript/api_status'
import CodeSnippetEvents from '../javascript/code_snippet_events'
import Navigation from '../javascript/navigation'
import Careers from '../javascript/careers'
import LocaleSwitcher from '../javascript/locale_switcher'

Rails.start()

$(document).ready(function() {
  Scroll()
  Notices()
  GithubCards()
  new VoltaTabbedExamples
  new Format
  APIStatus()
  Scroll()
  CodeSnippetEvents()
  Navigation()
  Spotlight()
  new Careers
  new LocaleSwitcher

  if (document.getElementById('jwt-generator-app')) {
    new Vue({
      el: '#jwt-generator-app',
      template: '<JwtGenerator/>',
      components: { JwtGenerator }
    })
  }

  if (document.getElementById('search-app')) {
    new Vue({
      el: '#search-app',
      template: '<Search/>',
      components: { Search }
    })
  }

  if (document.getElementById('feedback-app')) {
    new Vue({
      el: '#feedback-app',
      template: '<Feedback/>',
      render: createElement => {
        let context = {
          props: {
            codeLanguage: window.feedbackProps.code_language || window.initialLanguage,
            codeLanguageSelectedWhilstOnPage: window.feedbackProps.code_language_selected_whilst_on_page || false,
            codeLanguageSetByUrl: window.feedbackProps.code_language_set_by_url,
            currentUser: window.feedbackProps.current_user,
            feedbackAuthor: window.feedbackProps.feedback_author,
            githubUrl: window.feedbackProps.github_url,
            recaptcha: window.feedbackProps.recaptcha,
            source: window.feedbackProps.source
          }
        }
        return createElement(Feedback, context)
      }
    })
  }

  if (document.getElementById('concatenation-app')) {
    new Vue({
      el: '#concatenation-app',
      template: '<Concatenation/>',
      components: { Concatenation }
    })
  }

  // If we're on a two pane page, make sure that the main pane is focused
  let rightPane = document.querySelector(".Vlt-main");
  if (rightPane) { rightPane.click(); }

  Volta.init(['accordion', 'tooltip', 'tab', 'modal', 'dropdown'])

  setTimeout(function() {
    const sidebarActive = document.querySelector('.Vlt-sidemenu__link_active')
    if(sidebarActive){
      sidebarActive.scrollIntoView(true);
    }
  }, 100);

  // If there are any links in the sidebar, we need to be able to click them
  // and not trigger the Volta accordion
  $(".Vlt-sidemenu__trigger a").click(function(){
    window.location = $(this).attr("href");
    return false;
  });

  // Track A/B testing clicks
  $("[data-ab]").click(function(e) {
    let r =  new Request('/usage/ab_result', {
        method: 'POST',
        credentials: 'same-origin',
        body: JSON.stringify({'t': $(this).data('ab')}),
        headers: {
            'Content-Type': 'application/json'
        }
    });

    fetch(r).then((response) => {
        if (response.ok) { return response.json() }
        return Promise.reject({ message: 'Bad response from server', response })
    });
  });

  // Mermaid diagrams
  mermaid.initialize({
      startOnLoad:true,
      sequence: {
          useMaxWidth: false,
      },
      themeCSS: '.actor { fill: #BDD5EA; stroke: #81B1DB; }',
      htmlLabels: true
  });
});

