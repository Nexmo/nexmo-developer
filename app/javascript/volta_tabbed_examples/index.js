import UserPreference from './user_preference'

export default class VoltaTabbedExamples {
  constructor() {
    this.userPreference = new UserPreference(true);

    if ($('.Vlt-tabs').length) {
      this.context = $('.Vlt-tabs');
      this.restoreTabs = this.restoreTabs.bind(this)
      this.setupEvents = this.setupEvents.bind(this)
      this.onTabClick = this.onTabClick.bind(this)
      this.onPopState = this.onPopState.bind(this)
      this.persistLanguage = this.persistLanguage.bind(this)
      this.restoreTabs()
      this.setupEvents()
    }
  }

  shouldRestoreTabs() {
    return !this.context.find('.Vlt-tabs__header--bordered').data('has-initial-tab');
  }

  languages() {
    let obj = {}

    $(this.context).find(`[data-language]`).each(function(index, el) {
      $(el).data('language').split(',').forEach(function(language) {
        obj[language] = {
          platform: $(el).data('platform') || false
        }
      })
    })

    return obj
  }

  restoreTabs() {
    if (this.shouldRestoreTabs()) {
      let languages = this.languages()
      const language = this.userPreference.topMatch(Object.keys(languages))

      if (language) {
        if (languages[language]['platform']) {
          this.setPlatform(languages[language]['platform'], this.context)
        } else {
          this.setLanguage(language);
        }
      }
    } else {
      const selectedLanguage = this.context.find('li.Vlt-tabs__link_active').data('language');
      this.setLanguage(selectedLanguage);
    }
  }

  setupEvents() {
    $('.Vlt-tabs__link').click(this.onTabClick)
    $(window).on('popstate', this.onPopState)
  }

  onPopState(event) {
    if (window.history.state && window.history.state.language) {
      this.setLanguage(window.history.state.language)
    }
  }

  onTabClick(event) {
    // Prevent nested tabs from changing the url
    if ($(event.target).parents('.Vlt-tabs').length > 1) { return; }

    const language = $(event.currentTarget).data('language')
    const languageType = $(event.currentTarget).data('language-type')
    const linkable = $(event.currentTarget).data('language-linkable')

    if (language) {
      if (linkable) {
        document.dispatchEvent(new CustomEvent('codeLanguageChange', { "detail": { "language": language } }));
        if ($(".skip-pushstate").length == 0) {
            const rootPath = $('body').data('push-state-root')
            window.history.pushState({language}, 'language', `${rootPath}/${language}`)
        }
      }

      this.persistLanguage(language, languageType, linkable)
    }
  }

  persistLanguage(language, languageType) {
    if (language) {
      this.userPreference.promote(languageType, language)
    }
  }

  setLanguage(language) {
      setTimeout(() => {
        $(`[data-language='${language}']`).click();

        // Remove skip pushstate after the first load. This is a bit of a hack, but it works to stop breaking
        // the back button
        $(".skip-pushstate").removeClass('skip-pushstate');
      }, 0);
  }

  setPlatform(platform) {
      setTimeout(() => { $(`[data-platform='${platform}']`).click(); }, 0);
  }
}
