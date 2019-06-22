/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import '@babel/polyfill'

import { TweenLite, CSSPlugin } from 'gsap'
import React from 'react'
import ReactDOM from 'react-dom'
import GithubCards from '../github_cards'
import VoltaTabbedExamples from '../volta_tabbed_examples'
import Format from '../format'
import Scroll from '../scroll'
import Spotlight from '../spotlight'
import Search from '../components/search'
import Notices from '../notices'
import Feedback from '../components/feedback'
import Concatenation from '../components/concatenation'
import APIStatus from '../api_status'
import CodeSnippetEvents from '../code_snippet_events'
import JWTGenerator from '../components/jwt_generator'
import Navigation from '../navigation'

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

  if (document.getElementById('jwtGenerator')) {
    ReactDOM.render(<JWTGenerator/>, document.getElementById('jwtGenerator'))
  }

  if (document.getElementById('SearchComponent')) {
    ReactDOM.render(<Search/>, document.getElementById('SearchComponent'))
  }

  if (document.getElementById('FeedbackComponent')) {
    ReactDOM.render(<Feedback {...window.feedbackProps}/>, document.getElementById('FeedbackComponent'))
  }

  if (document.getElementById('ConcatenationComponent')) {
    ReactDOM.render(<Concatenation/>, document.getElementById('ConcatenationComponent'))
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
      theme: 'dark',
      htmlLabels: true
  });
});

