import { shallowMount } from '@vue/test-utils';
import ZendeskArticle from 'components/search/ZendeskArticle.vue';

describe('ZendeskArticle', function() {
  const article = {
    "title": "Nexmo APIs rock!",
    "id": "intro",
    "_snippetResult": { "body_safe": { "value": "highlighted snippet" } },
    "section": { "full_path": "full path" }
  };

  it('renders the article', function() {
    const wrapper = shallowMount(ZendeskArticle, { propsData: { "hit": article } });

    expect(wrapper.find('.Nxd-search__result__link').attributes().href).toEqual(
      'https://help.nexmo.com/hc/en-us/articles/intro'
    );

    expect(wrapper.find('h6.Vlt-blue-dark').text()).toEqual('Nexmo APIs rock!');

    expect(wrapper.find('.Nxd-search__result__highlight').text()).toEqual(
      '...highlighted snippet...'
    );

    expect(wrapper.find('.Nxd-search__badge').text()).toEqual('full path');
  });
});
