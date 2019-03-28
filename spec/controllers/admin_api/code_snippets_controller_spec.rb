require 'rails_helper'

RSpec.describe AdminApi::CodeSnippetsController, :request do
  before do
    Rails.application.routes.draw do
      get '/admin_api/code_snippets/' => 'code_snippets#index'
    end
  end
  after do
    Rails.application.reload_routes!
  end

  describe 'GET index' do
    it 'does something' do
      puts response
    end
  end
end
