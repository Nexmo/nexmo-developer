import Vue from 'vue';
import { shallowMount } from '@vue/test-utils';
import flushPromises from 'flush-promises';
import Feedback from 'components/feedback/Feedback.vue';

describe('Feedback', function() {
  const fetchMock = require('fetch-mock');
  const githubUrl = 'https://github.com/Nexmo/nexmo-developer/blob/master/_documentation/messaging/sms/guides/concatenation-and-encoding.md';
  const source = 'http://developer.nexmo.com';
  const currentUser = {
    email: 'admin@nexmo.com',
    signout_path: '/signout'
  };

  afterEach(fetchMock.reset);

  it('renders a link to improve the page if a githubUrl is provided', function() {
    const wrapperWithUrl = shallowMount(Feedback, { propsData: { githubUrl: githubUrl } });
    expect(wrapperWithUrl.find('#feedback__improve a').html()).toEqual(`<a href="${githubUrl}" target="_blank"> Improve this page</a>`);

    const wrapperWithoutUrl = shallowMount(Feedback);
    expect(wrapperWithoutUrl.find('#feedback__improve').exists()).toBeFalsy();
  });

  it('renders a link to log out if there is a currentUser', function() {
    const wrapperWithUser = shallowMount(Feedback, { propsData: { currentUser: currentUser } });

    expect(wrapperWithUser.text()).toContain('Logged in as admin@nexmo.com.');
    expect(wrapperWithUser.find('a[href="/signout"]').text()).toEqual('Sign out');

    const wrapperWithoutUser = shallowMount(Feedback);
    expect(wrapperWithoutUser.text()).not.toContain('Logged in');
  });

  it('allows the user to provide feedback', function() {
    const wrapper = shallowMount(Feedback, { propsData: { currentUser: currentUser, githubUrl: githubUrl }});

    expect(wrapper.find('h5').text()).toEqual('Was this documentation helpful?');
    expect(wrapper.find('.Vlt-green')).toBeTruthy();
    expect(wrapper.find('.Vlt-red')).toBeTruthy();
  });

  describe('Providing positive feedback', function() {
    const parameters = {
      method: 'post',
      headers: { 'Content-Type': 'application/json' },
      body: {
        "feedback_feedback": {
          "sentiment": "positive",
          "comment": "",
          "email": "admin@nexmo.com",
          "source": "http://developer.nexmo.com"
        }
      }
    };

    it('submits successfully', function() {
      fetchMock.mock(
        '/feedback/feedbacks',
        { id: '123' },
        parameters
      )
      const wrapper = shallowMount(Feedback, { propsData: { currentUser: currentUser, githubUrl: githubUrl, source: source }});

      wrapper.find('.Vlt-green').trigger('click');

      expect(wrapper.find('.Vlt-spinner')).toBeTruthy();
      expect(wrapper.find('.Vlt-btn_active .Vlt-green')).toBeTruthy();
      expect(wrapper.text()).toContain('Great! Thanks for the feedback.');
    });

    it('shows a message when there was an error with the submission', async function() {
      fetchMock.mock(
        '/feedback/feedbacks',
        Promise.resolve({ status: 422, body: { error: 'There was an error' } }),
        parameters
      )
      const wrapper = shallowMount(
        Feedback,
        {
          propsData: { currentUser: currentUser, githubUrl: githubUrl, source: source },
        }
      );

      wrapper.find('.Vlt-green').trigger('click');

      await flushPromises();
      expect(wrapper.find('.Vlt-spinner')).toBeTruthy();
      expect(wrapper.find('.Vlt-btn_active .Vlt-green')).toBeTruthy();
      expect(wrapper.find('.form__error').text()).toEqual('There was an error');
    });
  });

  describe('Providing negative feedback', function() {
    describe('with a user', function() {
      const parameters = {
        method: 'post',
        headers: { 'Content-Type': 'application/json' },
        body: {
          "feedback_feedback": {
            "sentiment": "negative",
            "comment": "",
            "email": "admin@nexmo.com",
            "source": "http://developer.nexmo.com"
          }
        }
      };
      const updateParams = {
        method: 'post',
        headers: { 'Content-Type': 'application/json' },
        body: {
          "feedback_feedback": {
            "sentiment": "negative",
            "comment": "One of the examples did not work for me",
            "email": "admin@nexmo.com",
            "source": "http://developer.nexmo.com",
            "id": "123"
          }
        },
        overwriteRoutes: true
      };

      it('submits successfully', async function() {
        fetchMock.mock(
          '/feedback/feedbacks',
          { id: '123' },
          parameters
        )
        const wrapper = shallowMount(Feedback, { propsData: { currentUser: currentUser, githubUrl: githubUrl }});

        wrapper.find('.Vlt-red').trigger('click');

        await flushPromises();

        expect(wrapper.find('.Vlt-spinner')).toBeTruthy();
        expect(wrapper.find('.Vlt-btn_active .Vlt-red')).toBeTruthy();

        expect(wrapper.vm.id).toEqual('123');

        expect(wrapper.text()).toContain(
          'We see that this page didn’t meet your expectations. We’re really sorry!'
        );
        expect(wrapper.find('.Vlt-form__element strong').text()).toEqual(
          'We’d like a chance to fix that. Please would you give us some more information?'
        );
        expect(wrapper.find('.Vlt-form__element .Vlt-label').text()).toEqual("What didn’t work for me: (required)");

        expect(wrapper.find('input[type="submit"][disabled="disabled"]').element.value).toEqual('Send Feedback');

        wrapper.find('textarea').setValue('One of the examples did not work for me');

        expect(wrapper.find('input[type="submit"]').attributes()['disabled']).toBeUndefined();

        expect(wrapper.find('input[type="submit"]').element.attrs).toBeFalsy();

        fetchMock.mock('/feedback/feedbacks', { id: '123' }, updateParams);

        wrapper.find('input[type="submit"]').trigger('click')

        await flushPromises();

        expect(wrapper.text()).toContain('Great! Thanks for the feedback.');
      });
    });

    describe('without an user', function() {
      const parameters = {
        method: 'post',
        headers: { 'Content-Type': 'application/json' },
        body: {
          "feedback_feedback": {
            "sentiment": "negative",
            "comment": "",
            "email": "",
            "source": "http://developer.nexmo.com"
          }
        }
      };
      const updateParams = {
        method: 'post',
        headers: { 'Content-Type': 'application/json' },
        body: {
          "feedback_feedback": {
            "sentiment": "negative",
            "comment": "One of the examples did not work for me",
            "email": "test@nexmo.com",
            "source": "http://developer.nexmo.com",
            "id": "123"
          }
        },
        overwriteRoutes: true
      };

      it('submits successfully', async function() {
        fetchMock.mock(
          '/feedback/feedbacks',
          { id: '123' },
          parameters
        )
        const wrapper = shallowMount(Feedback, { propsData: { githubUrl: githubUrl }});

        wrapper.find('.Vlt-red').trigger('click');

        await flushPromises();

        expect(wrapper.find('.Vlt-spinner')).toBeTruthy();
        expect(wrapper.find('.Vlt-btn_active .Vlt-red')).toBeTruthy();

        expect(wrapper.vm.id).toEqual('123');

        expect(wrapper.text()).toContain(
          'We see that this page didn’t meet your expectations. We’re really sorry!'
        );
        expect(wrapper.find('.Vlt-form__element strong').text()).toEqual(
          'We’d like a chance to fix that. Please would you give us some more information?'
        );
        expect(wrapper.find('.Vlt-form__element .Vlt-label').text()).toEqual("What didn’t work for me: (required)");

        expect(wrapper.find('.Vlt-form__element--elastic p').text()).toEqual("Can we let you know when we've solved your issue?");
        expect(wrapper.find('input[type="submit"][disabled="disabled"]').element.value).toEqual('Send Feedback');
        wrapper.find('input[type="email"]').setValue('test@nexmo.com');

        wrapper.find('textarea').setValue('One of the examples did not work for me');

        expect(wrapper.find('input[type="submit"]').attributes()['disabled']).toBeUndefined();

        expect(wrapper.find('input[type="submit"]').element.attrs).toBeFalsy();

        fetchMock.mock('/feedback/feedbacks', { id: '123' }, updateParams);

        wrapper.find('input[type="submit"]').trigger('click')

        await flushPromises();

        expect(wrapper.text()).toContain('Great! Thanks for the feedback.');
      });


      it('with captcha enabled', async function() {
        document.body.innerHTML = "<div id='recaptcha-container'></div>"
        fetchMock.mock(
          '/feedback/feedbacks',
          { id: '123' },
          parameters
        )
        global.grecaptcha = {
          render: jest.fn(() => 'id'),
          execute: jest.fn(),
        };

        const wrapper = shallowMount(Feedback, { attachToDocument: true, propsData: { recaptcha: { enabled: true } }});
        wrapper.find('.Vlt-red').trigger('click');

        expect(global.grecaptcha.render).toBeCalled();
        expect(global.grecaptcha.execute).toBeCalled();

        await flushPromises();

        expect(wrapper.find('.Vlt-spinner')).toBeTruthy();
        expect(wrapper.find('.Vlt-btn_active .Vlt-red')).toBeTruthy();

        wrapper.destroy();
      });
    });
  });
});
