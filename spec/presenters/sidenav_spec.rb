require 'rails_helper'

RSpec.describe Sidenav do
  let(:request_path) { '/en/documentation' }
  let(:product)      { nil }
  let(:locale)       { 'en' }
  let(:navigation)   { :documentation }
  let(:namespace)    { nil }

  before do
    @sidenav = described_class.new(
      request_path: request_path,
      product: product,
      locale: locale,
      navigation: navigation,
      namespace: namespace
    )
  end

  describe '#namespace' do
    it { expect(@sidenav.namespace).to eq('documentation') }

    context 'specifying a namespace' do
      let(:namespace) { 'namespace' }

      it { expect(@sidenav.namespace).to eq('namespace') }
    end
  end

  describe '#nav_items' do
    it 'returns instances of SidenavItem' do
      @sidenav.nav_items.each { |item| expect(item).to be_an_instance_of(SidenavItem) }
    end
  end

  describe '#locale' do
    it { expect(@sidenav.locale).to eq('en') }

    context 'without specifying a locale' do
      let(:locale) { nil }

      it { expect(@sidenav.locale).to be_nil }
    end
  end
end
