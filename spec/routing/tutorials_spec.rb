require 'rails_helper'

RSpec.describe 'tutorials routes', type: :routing do
  describe 'tutorial#single' do
    it 'routes /task/client-sdk/generate-jwt' do
      expect(get('/task/client-sdk/generate-jwt'))
        .to route_to(controller: 'tutorial', action: 'single', tutorial_step: 'client-sdk/generate-jwt')
    end
  end

  describe 'tutorial#list' do
    it 'routes /tutorials' do
      expect(get('/tutorials')).to route_to(controller: 'tutorial', action: 'list')
    end

    it 'routes /messaging/sms/tutorials' do
      expect(get('/messaging/sms/tutorials'))
        .to route_to(controller: 'tutorial', action: 'list', product: 'messaging/sms')
    end
  end

  describe 'tutorial#index' do
    context 'with a product' do
      it 'routes /client-sdk/tutorials/ios-in-app-messaging/introduction' do
        expect(get('/client-sdk/tutorials/ios-in-app-messaging/introduction'))
          .to route_to(controller: 'tutorial', action: 'index', product: 'client-sdk', tutorial_step: 'introduction', tutorial_name: 'ios-in-app-messaging')
      end

      it 'routes /client-sdk/tutorials/ios-in-app-messaging/introduction/node' do
        expect(get('/client-sdk/tutorials/ios-in-app-messaging/introduction/node'))
          .to route_to(controller: 'tutorial', action: 'index', product: 'client-sdk', tutorial_step: 'introduction', tutorial_name: 'ios-in-app-messaging', code_language: 'node')
      end

      it 'routes /client-sdk/tutorials/ios-in-app-messaging' do
        expect(get('/client-sdk/tutorials/ios-in-app-messaging'))
          .to route_to(controller: 'tutorial', action: 'index', product: 'client-sdk', tutorial_name: 'ios-in-app-messaging')
      end
    end
  end
end
