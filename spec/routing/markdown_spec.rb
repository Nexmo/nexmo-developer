require 'rails_helper'

RSpec.describe 'markdown routes', type: :routing do
  describe 'markdown#show' do
    it 'routes /product-lifecycle/dev-preview' do
      expect(get('/product-lifecycle/dev-preview'))
        .to route_to(controller: 'markdown', action: 'show', document: 'dev-preview', namespace: 'product-lifecycle')
    end

    it 'routes /en/product-lifecycle/dev-preview' do
      expect(get('/en/product-lifecycle/dev-preview'))
        .to route_to(controller: 'markdown', action: 'show', document: 'dev-preview', namespace: 'product-lifecycle', locale: 'en')
    end

    it 'routes /contribute/overview' do
      expect(get('/contribute/overview'))
        .to route_to(controller: 'markdown', action: 'show', document: 'overview', namespace: 'contribute')
    end

    it 'routes /en/contribute/overview' do
      expect(get('/en/contribute/overview'))
        .to route_to(controller: 'markdown', action: 'show', document: 'overview', namespace: 'contribute', locale: 'en')
    end

    it '/contribute/code-snippets/sample-code-snippet/ruby' do
      expect(get('/contribute/code-snippets/sample-code-snippet/ruby'))
        .to route_to(controller: 'markdown', action: 'show', document: 'code-snippets/sample-code-snippet', namespace: 'contribute', code_language: 'ruby')
    end

    it '/en/contribute/code-snippets/sample-code-snippet/ruby' do
      expect(get('/en/contribute/code-snippets/sample-code-snippet/ruby'))
        .to route_to(controller: 'markdown', action: 'show', document: 'code-snippets/sample-code-snippet', namespace: 'contribute', code_language: 'ruby', locale: 'en')
    end

    DocumentationConstraint.products_for_routes.each do |path|
      it "/#{path}/overview" do
        expect(get("/#{path}/overview"))
          .to route_to(controller: 'markdown', action: 'show', product: path, document: 'overview')
      end

      it "/en/#{path}/overview" do
        expect(get("/en/#{path}/overview"))
          .to route_to(controller: 'markdown', action: 'show', product: path, document: 'overview', locale: 'en')
      end

      it "/en/#{path}/overview/ruby" do
        expect(get("/en/#{path}/overview/ruby"))
          .to route_to(controller: 'markdown', action: 'show', product: path, document: 'overview', locale: 'en', code_language: 'ruby')
      end
    end
  end
end
