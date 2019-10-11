import algoliasearch from 'algoliasearch'
import Vue from 'vue';
import { mount } from '@vue/test-utils';
import flushPromises from 'flush-promises';

import searchFixture from 'javascript/fixtures/search';
import emptySearchFixture from 'javascript/fixtures/emptySearch';

import Search from 'components/search/Search.vue';
import NDPArticle from 'components/search/NDPArticle.vue';
import ZendeskArticle from 'components/search/ZendeskArticle.vue';

jest.mock('algoliasearch');
jest.mock('lodash/debounce', () => jest.fn(fn => fn));

describe('Search', function() {

  beforeAll(function() {
    const algoliaId = window.document.createElement('meta');
    algoliaId.name = 'algolia_application_id';
    algoliaId.content = 'DUMMY_ID';

    const algoliaSearch = window.document.createElement('meta');
    algoliaSearch.name = 'algolia_search_key';
    algoliaSearch.content = 'DUMMY_KEY';

    window.document.body.append(algoliaId, algoliaSearch);
  })

  describe('with results', function() {
    beforeEach(function() {
      algoliasearch.mockImplementation(function() {
        return {
          search: function() {
            return Promise.resolve(searchFixture);
          }
        }
      });
    });

    it('renders the results', async function() {
      const wrapper = mount(Search, { attachToDocument: true });

      wrapper.find('input').setValue('test');

      await flushPromises();
      wrapper.vm.$nextTick();

      expect(wrapper.find(ZendeskArticle).exists()).toBeTruthy();
      expect(wrapper.find(NDPArticle).exists()).toBeTruthy();
    });
  });

  describe('without results', function() {
    beforeEach(function() {
      algoliasearch.mockImplementation(function() {
        return {
          search: function() {
            return Promise.resolve(emptySearchFixture);
          }
        }
      });
    });

    it('allows the user to perform searches and renders the results', async function() {
      const wrapper = mount(Search, { attachToDocument: true });

      wrapper.find('input').setValue('empty');

      await flushPromises();

      expect(wrapper.text()).toContain('Nexmo Developer');
      expect(wrapper.text()).toContain('Knowledgebase');
      expect(wrapper.text()).toContain('No results');
    });
  });
});
