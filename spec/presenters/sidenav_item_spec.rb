require 'rails_helper'

RSpec.describe SidenavItem do
  let(:locale) { nil }
  let(:folder) do
    {
      children: [{ title: 'overview.md', path: '_documentation/en/dispatch/overview.md', is_file?: true }],
      title: 'dispatch',
      path: '_documentation/en/dispatch',
    }
  end

  subject do
    described_class.new(
      folder: folder,
      sidenav: instance_double(Sidenav, locale: locale)
    )
  end

  describe '#svg?' do
    it 'returns true if the folder has an svg to display' do
      expect(subject.svg?).to be_truthy
    end
  end

  describe '#svg' do
    it 'returns the svg ref' do
      expect(subject.svg).to eq('/symbol/volta-icons.svg#Vlt-icon-flow')
    end
  end

  describe '#svg_color' do
    it { expect(subject.svg_color).to eq('Vlt-gray-darker') }
  end

  describe '#label?' do
    it 'returns true if there is a label to display' do
      expect(subject.label?).to eq(true)
    end
  end

  describe '#label' do
    it 'returns the label to be displayed' do
      expect(subject.label).to eq('Beta')
    end
  end

  describe '#children' do
    it { subject.children.each { |child| expect(child).to be_an_instance_of(SidenavSubitem) } }
  end

  describe '#css_classes' do
    it { expect(subject.css_classes).to eq('Vlt-badge Vlt-badge--margin-left Vlt-badge--small Vlt-bg-green-lighter Vlt-green') }
  end

  describe 'link_url' do
    it 'returns the url of the label' do
      expect(subject.link_url).to eq('/product-lifecycle/beta')
    end
  end

  describe '#normalized_title' do
    it { expect(subject.normalized_title).to eq('Dispatch API') }
  end

  describe '#title' do
    it 'returns the provided title' do
      expect(subject.title).to eq('dispatch')
    end
  end
end
