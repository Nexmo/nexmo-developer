import { shallowMount } from '@vue/test-utils';
import NDPArticle from 'components/search/NDPArticle.vue';

describe('NDPArticle', function() {
  const article = {
    "title": "Nexmo APIs rock!",
    "heading": "Nexmo APIs rock!",
    "description": "Awesome set of APIs",
    "path": "https://help.nexmo.com/awesome-article",
    "anchor": "intro",
    "_snippetResult": { "body": { "value": "highlighted snippet" } },
    "product": "product badge"
  };

  it('renders the article', function() {
    const wrapper = shallowMount(NDPArticle, { propsData: { "hit": article } });

    expect(wrapper.find('.Nxd-search__result__link').attributes().href).toEqual(
      'https://help.nexmo.com/awesome-article#intro'
    );

    expect(wrapper.find('h6').text()).toEqual(
      `Nexmo APIs rock!
         > Nexmo APIs rock!`
    );

    expect(wrapper.find('.Nxd-search__result__desc').text()).toEqual(
      'Awesome set of APIs'
    );

    expect(wrapper.find('.Nxd-search__result__highlight').text()).toEqual(
      '...highlighted snippet...'
    );

    expect(wrapper.find('.Nxd-search__badge').text()).toEqual(
      'product badge'
    );
  });

  it('renders subheading only when the heading matches the title', function() {
    let wrapper = shallowMount(NDPArticle, { propsData: { "hit": article } });

    expect(wrapper.find('h6 small').text()).toEqual('> Nexmo APIs rock!');

    article.heading = '';
    wrapper = shallowMount(NDPArticle, { propsData: { "hit": article } });
    expect(wrapper.find('h6 small').exists()).toBe(false);
  });
});
