require 'rails_helper'

RSpec.describe OpenApi::ExampleResponseResolver do
  context 'petstore' do
    before(:each) do
      @specification = OpenApiParser::Specification.resolve('spec/fixtures/open_api/petstore.yml')
    end

    it 'has a resolved path' do
      resolver = OpenApi::ExampleResponseResolver.new(@specification, path: '/pets/{id}', method: 'get')
      expect(resolver.resolved_path).to eq('/pets/1')
    end

    it 'has a status' do
      resolver = OpenApi::ExampleResponseResolver.new(@specification, path: '/pets/{id}', method: 'get')
      expect(resolver.status).to eq('200')
    end


    describe 'GET /pets' do
      it 'provides an example response for an object' do
        resolver = OpenApi::ExampleResponseResolver.new(@specification, path: '/pets', method: 'get')
        expect(resolver.model.length).to eq(1)
        expect(resolver.model[0]['id']).to eq(1)
        expect(resolver.model[0]['name']).to eq('abc123')
        expect(resolver.model[0]['tag']).to eq('abc123')
      end
    end

    describe 'POST /pets' do
      it 'provides an example response for an object' do
        resolver = OpenApi::ExampleResponseResolver.new(@specification, path: '/pets', method: 'post')
        expect(resolver.model['id']).to eq(1)
      end
    end

    describe 'GET /pets/{id}' do
      it 'provides an example response for an object' do
        resolver = OpenApi::ExampleResponseResolver.new(@specification, path: '/pets/{id}', method: 'get')
        expect(resolver.model['id']).to eq(1)
        expect(resolver.model['name']).to eq('abc123')
        expect(resolver.model['tag']).to eq('abc123')
      end
    end

    describe 'DELETE /pets/{id}' do
      it 'provides an example response for an object' do
        resolver = OpenApi::ExampleResponseResolver.new(@specification, path: '/pets/{id}', method: 'delete')
        expect(resolver.model).to be_nil
      end
    end
  end

  context 'petstore-expanded' do
    before(:each) do
      @specification = OpenApiParser::Specification.resolve('spec/fixtures/open_api/petstore-expanded.yml')
    end

    it 'has a resolved path' do
      resolver = OpenApi::ExampleResponseResolver.new(@specification, path: '/pets/{id}', method: 'get')
      expect(resolver.resolved_path).to eq('/pets/1')
    end

    it 'has a status' do
      resolver = OpenApi::ExampleResponseResolver.new(@specification, path: '/pets/{id}', method: 'get')
      expect(resolver.status).to eq('200')
    end


    describe 'GET /pets' do
      it 'provides an example response for an object' do
        resolver = OpenApi::ExampleResponseResolver.new(@specification, path: '/pets', method: 'get')
        expect(resolver.model.length).to eq(1)
        expect(resolver.model[0]['id']).to eq(1)
        expect(resolver.model[0]['name']).to eq('abc123')
        expect(resolver.model[0]['tag']).to eq('abc123')
      end
    end

    describe 'POST /pets' do
      it 'provides an example response for an object' do
        resolver = OpenApi::ExampleResponseResolver.new(@specification, path: '/pets', method: 'post')
        expect(resolver.model['id']).to eq(1)
      end
    end

    describe 'GET /pets/{id}' do
      it 'provides an example response for an object' do
        resolver = OpenApi::ExampleResponseResolver.new(@specification, path: '/pets/{id}', method: 'get')
        expect(resolver.model['id']).to eq(1)
        expect(resolver.model['name']).to eq('abc123')
        expect(resolver.model['tag']).to eq('abc123')
      end
    end

    describe 'DELETE /pets/{id}' do
      it 'provides an example response for an object' do
        resolver = OpenApi::ExampleResponseResolver.new(@specification, path: '/pets/{id}', method: 'delete')
        expect(resolver.model).to be_nil
      end
    end
  end

  context 'petstore-jwt' do
    before(:each) do
      @specification = OpenApiParser::Specification.resolve('spec/fixtures/open_api/petstore-jwt.yml')
    end

    it 'has a resolved path' do
      resolver = OpenApi::ExampleResponseResolver.new(@specification, path: '/pets', method: 'get')
      expect(resolver.endpoint.raw['security']).to include('jwt')
    end
  end

  context 'uber' do
    before(:each) do
      @specification = OpenApiParser::Specification.resolve('_open_api/example/uber.yml')
    end

    it 'has a resolved path' do
      resolver = OpenApi::ExampleResponseResolver.new(@specification, path: '/products', method: 'get')
      expect(resolver.resolved_path).to eq('/products')
    end

    describe 'GET /products' do
      it 'provides an example response for an object' do
        resolver = OpenApi::ExampleResponseResolver.new(@specification, path: '/products', method: 'get')
        expect(resolver.model.length).to eq(1)
      end
    end

    describe 'GET /history' do
      it 'provides an example response for an object' do
        resolver = OpenApi::ExampleResponseResolver.new(@specification, path: '/history', method: 'get')
        expect(resolver.model.length).to eq(4)
      end
    end

    describe 'GET /me' do
      it 'provides an example response for an object' do
        resolver = OpenApi::ExampleResponseResolver.new(@specification, path: '/me', method: 'get')
        expect(resolver.model.length).to eq(5)
      end
    end
  end

  context 'sms' do
    before(:each) do
      @specification = OpenApiParser::Specification.resolve('spec/fixtures/open_api/sms.yml')
    end

    it 'has a resolved path' do
      resolver = OpenApi::ExampleResponseResolver.new(@specification, path: '/sms/{format}', method: 'post')
      expect(resolver.resolved_path).to eq('/sms/json')
    end

    it 'has a status' do
      resolver = OpenApi::ExampleResponseResolver.new(@specification, path: '/sms/{format}', method: 'post')
      expect(resolver.status).to eq('200')
    end

    it 'provides an example response for an object' do
      resolver = OpenApi::ExampleResponseResolver.new(@specification, path: '/sms/{format}', method: 'post')
      expect(resolver.model['message-count']).to eq(1)
      expect(resolver.model['messages']['to']).to eq('447700900000')
      expect(resolver.model['messages']['network']).to eq('12345')
    end
  end
end
