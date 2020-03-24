require 'rails_helper'

RSpec.describe SidenavSubitem do
  let(:locale) { nil }
  let(:folder) do
    {
      title: 'overview.md',
      path: "#{Rails.configuration.docs_base_path}/_documentation/en/concepts/overview.md",
      is_file?: true,
    }
  end

  let(:sidenav) do
    instance_double(
      Sidenav,
      navigation: :documentation,
      request_path: '/concepts/overview',
      documentation?: true,
      code_language: nil,
      locale: locale
    )
  end

  subject { described_class.new(folder: folder, sidenav: sidenav) }

  describe '#title' do
    it 'delegates the title generation to TitleNormalizer' do
      expect(TitleNormalizer).to receive(:call).with(folder).and_return('Example Title')
      subject.title
    end
  end

  describe '#show_link?' do
    it { expect(subject.show_link?).to eq(true) }
  end

  describe '#collapsible?' do
    it { expect(subject.collapsible?).to eq(true) }
  end

  describe '#url' do
    context 'for a document' do
      it { expect(subject.url).to eq('/concepts/overview') }
    end

    context 'otherwise' do
      let(:folder) do
        { title: 'beta.md', path: 'app/views/product-lifecycle/beta.md', is_file?: true }
      end

      let(:sidenav) do
        instance_double(
          Sidenav,
          navigation: :documentation,
          namespace: 'product-lifecycle',
          request_path: '/product-lifecycle/dev-preview',
          documentation?: false,
          locale: nil
        )
      end

      it { expect(subject.url).to eq('/product-lifecycle/beta') }
    end
  end

  describe '#buid_url' do
    context 'for a tutorial' do
      let(:folder) do
        {
          root: 'config/tutorials',
          path: 'config/tutorials/en/phone-to-app.yml',
          filename: 'phone-to-app',
          external_link: nil,
          title: 'Receiving an in-app voice call',
          description: 'Your web app receives an inbound phone call.',
          products: ['client-sdk'],
          is_file?: true,
          is_task?: true,
          product: 'client-sdk',
        }
      end

      it { expect(subject.build_url).to eq('/client-sdk/tutorials/phone-to-app') }

      context 'specifying a locale' do
        let(:locale) { :en }

        it { expect(subject.build_url).to eq('/client-sdk/tutorials/phone-to-app') }
      end
    end

    context 'for a use-case' do
      let(:folder) do
        {
          root: "#{Rails.configuration.docs_base_path}/_use_cases",
          path: "#{Rails.configuration.docs_base_path}/_use_cases/en/sending-whatsapp-messages-with-messages-api.md",
          title: 'Click to Call',
          product: 'messages',
          is_file?: true,
          is_tutorial?: true,
        }
      end

      it { expect(subject.build_url).to eq('/use-cases/sending-whatsapp-messages-with-messages-api') }

      context 'specifying a locale' do
        let(:locale) { :en }

        it { expect(subject.build_url).to eq('/use-cases/sending-whatsapp-messages-with-messages-api') }
      end
    end

    context 'otherwise' do
      it { expect(subject.build_url).to eq('/concepts/overview') }

      context 'specifying a locale' do
        let(:locale) { :en }

        it { expect(subject.build_url).to eq('/en/concepts/overview') }
      end
    end
  end
end
