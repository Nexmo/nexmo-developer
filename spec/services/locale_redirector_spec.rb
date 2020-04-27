require 'rails_helper'

RSpec.describe LocaleRedirector do
  let(:locale) { 'en' }
  let(:request) do
    double(
      'Request',
      protocol: 'https://',
      host_with_port: 'developer.nexmo.com',
      referrer: url
    )
  end

  subject { described_class.new(request, preferred_locale: locale).path }

  context 'from english to chinese' do
    let(:locale) { 'cn' }
    let(:url) do
      'https://developer.nexmo.com/concepts/overview'
    end

    it { expect(subject).to eq('/cn/concepts/overview') }
  end

  context 'from english to english' do
    let(:url) do
      'https://developer.nexmo.com/concepts/overview'
    end

    it { expect(subject).to eq('/concepts/overview') }
  end

  context 'from chinese to english' do
    let(:url) do
      'https://developer.nexmo.com/cn/concepts/overview'
    end

    it { expect(subject).to eq('/concepts/overview') }
  end

  context 'from chinese to chinese' do
    let(:locale) { 'cn' }
    let(:url) do
      'https://developer.nexmo.com/cn/concepts/overview'
    end

    it { expect(subject).to eq('/cn/concepts/overview') }
  end

  context 'root path' do
    let(:locale) { 'cn' }
    let(:url) do
      'https://developer.nexmo.com/'
    end

    it { expect(subject).to eq('/') }
  end

  context 'use-cases' do
    let(:locale) { 'cn' }
    let(:url) do
      'https://developer.nexmo.com/use-cases/client-sdk-click-to-call'
    end

    it { expect(subject).to eq('/use-cases/client-sdk-click-to-call') }
  end

  context 'tutorials' do
    let(:locale) { 'cn' }
    let(:url) do
      'https://developer.nexmo.com/client-sdk/tutorials/phone-to-app/introduction'
    end

    it { expect(subject).to eq('/client-sdk/tutorials/phone-to-app/introduction') }
  end

  context 'api' do
    let(:locale) { 'cn' }
    let(:url) do
      'https://developer.nexmo.com/api'
    end

    it { expect(subject).to eq('/api') }
  end

  describe '#add_locale?' do
  end
end
