require 'rails_helper'

RSpec.describe NotFoundNotifier do
  context '#crawler?' do
    it 'reports if a user agent is a crawler' do
      crawler = 'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)'
      user = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36'

      expect(NotFoundNotifier.crawler?(crawler)).to eq(true)
      expect(NotFoundNotifier.crawler?(user)).to eq(false)
    end
  end

  context '#ignored_format?' do
    it 'returns true for nil' do
      expect(NotFoundNotifier.ignored_format?(nil)).to eq(false)
    end

    it 'returns true for php' do
      expect(NotFoundNotifier.ignored_format?('PHP')).to eq(true)
      expect(NotFoundNotifier.ignored_format?('php')).to eq(true)
    end

    it 'returns false for an unmatched value' do
      expect(NotFoundNotifier.ignored_format?('foobar')).to eq(false)
    end
  end
end
