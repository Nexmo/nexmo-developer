require 'rails_helper'

RSpec.describe 'use-cases routes', type: :routing do
  describe 'use_case#index' do
    it 'routes /use-cases' do
      expect(get('/use-cases')).to route_to(controller: 'use_case', action: 'index')
    end

    it 'routes /use-cases/node' do
      expect(get('/use-cases/node')).to route_to(controller: 'use_case', action: 'index', code_language: 'node')
    end

    context 'specifying a product' do
      Product.all.each do |product|
        it "routes /#{product['path']}/use-cases" do
          expect(get("/#{product['path']}/use-cases"))
            .to route_to(controller: 'use_case', action: 'index', product: product['path'])
        end

        it "routes /#{product['path']}/use-cases/node" do
          expect(get("/#{product['path']}/use-cases/node"))
            .to route_to(controller: 'use_case', action: 'index', product: product['path'], code_language: 'node')
        end
      end
    end
  end

  describe 'use_case#show' do
    it 'routes /use-cases/contact-center-client-sdk' do
      expect(get('/use-cases/contact-center-client-sdk'))
        .to route_to(controller: 'use_case', action: 'show', document: 'contact-center-client-sdk')
    end

    it 'routes /use-cases/contact-center-client-sdk/node' do
      expect(get('/use-cases/contact-center-client-sdk/node'))
        .to route_to(controller: 'use_case', action: 'show', document: 'contact-center-client-sdk', code_language: 'node')
    end
  end
end
