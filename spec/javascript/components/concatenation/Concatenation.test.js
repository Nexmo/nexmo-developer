import { shallowMount } from '@vue/test-utils';
import Concatenation from 'components/concatenation/Concatenation.vue';

describe('Concatenation', function() {
  describe('Initial rendering', function() {
    it('Renders the default message', async function() {
      const wrapper = shallowMount(Concatenation);

      expect(wrapper.find('h2').text()).toEqual('Try it out');
      expect(wrapper.html()).toContain('<h4>Message</h4>');
      expect(wrapper.find('textarea').element.value).toEqual(
        "It was the best of times, it was the worst of times, it was the age of wisdom, it was the age of foolishness, it was the epoch of belief, it was the epoch of incredulity, it was the season of Light, it was the season of Darkness, it was the spring of hope, it was the winter of despair, we had everything before us, we had nothing before us, we were all going direct to Heaven, we were all going direct the other way in short, the period was so far like the present period, that some of its noisiest authorities insisted on its being received, for good or for evil, in the superlative degree of comparison only."
      );

      expect(wrapper.html()).toContain('<h4>Data</h4>');
      expect(wrapper.find('b').text()).toEqual('Unicode is Required?');
      expect(wrapper.find('i.color--error').exists()).toBeTruthy();

      expect(wrapper.html()).toContain('<b>Length</b>');
      expect(wrapper.find('#sms-composition').text()).toEqual('611 characters sent in 4 message parts');

      expect(wrapper.html()).toContain('<h4>Parts</h4>');

      expect(wrapper.findAll('.Vlt-badge--blue').length).toEqual(4);

      const parts = wrapper.findAll('#parts .Vlt-grid');
      const part1 = parts.at(0);
      const part2 = parts.at(1);
      const part3 = parts.at(2);
      const part4 = parts.at(3);

      expect(part1.find('.Vlt-badge--blue').text()).toEqual('User Defined Header');
      expect(part1.find('b').text()).toEqual('Part 1');
      expect(part1.find('code').text()).toContain(
        'It was the best of times, it was the worst of times, it was the age of wisdom, it was the age of foolishness, it was the epoch of belief, it was the epoc'
      );

      expect(part2.find('.Vlt-badge--blue').text()).toEqual('User Defined Header');
      expect(part2.find('b').text()).toEqual('Part 2');
      expect(part2.find('code').text()).toContain(
        'h of incredulity, it was the season of Light, it was the season of Darkness, it was the spring of hope, it was the winter of despair, we had everything b'
      );

      expect(part3.find('.Vlt-badge--blue').text()).toEqual('User Defined Header');
      expect(part3.find('b').text()).toEqual('Part 3');
      expect(part3.find('code').text()).toContain(
        'efore us, we had nothing before us, we were all going direct to Heaven, we were all going direct the other way in short, the period was so far like the p'
      );

      expect(part4.find('.Vlt-badge--blue').text()).toEqual('User Defined Header');
      expect(part4.find('b').text()).toEqual('Part 4');
      expect(part4.find('code').text()).toContain(
        'resent period, that some of its noisiest authorities insisted on its being received, for good or for evil, in the superlative degree of comparison only.'
      );
    });

    it('notifies the user if unicode is required and updates the UI accordingly', function() {
      const wrapper = shallowMount(Concatenation);

      wrapper.find('textarea').setValue('😀');
      expect(wrapper.find('i.color--success').exists()).toBeTruthy();
      expect(wrapper.find('#sms-composition').text()).toEqual('2 characters sent in 1 message part');
      expect(wrapper.find('code').text()).toContain('😀');

      wrapper.find('textarea').setValue('not unicode');
      expect(wrapper.find('i.color--error').exists()).toBeTruthy();
      expect(wrapper.find('#sms-composition').text()).toEqual('11 characters sent in 1 message part');
      expect(wrapper.find('code').text()).toContain('not unicode');
    });
  });
});
