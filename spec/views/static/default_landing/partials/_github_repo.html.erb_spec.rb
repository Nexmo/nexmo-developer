require 'rails_helper'

RSpec.describe 'rendering _github_repo landing page partial' do
  it 'renders correctly' do
    repo_url = 'https://example.com/org/repo-name'
    github_repo_title = 'This is a sample title'
    language = 'Ruby'

    render partial: '/static/default_landing/partials/github_repo.html.erb', locals: {
        'repo_url' => repo_url,
        'github_repo_title' => github_repo_title,
        'language' => language,
    }

    expect(rendered).to include('<a class="Vlt-card Nxd-github-card Vlt-left" href="https://example.com/org/repo-name" data-github="Nexmo/repo-name">')
    expect(rendered).to include('<h3 class="Vlt-blue-dark">repo-name</h3>')
    expect(rendered).to include('<p>This is a sample title</p>')
    expect(rendered).to include('<span class="Vlt-blue-dark">●</span> Ruby')
  end

  it 'raises an error if repo_url key is missing' do
    github_repo_title = 'This is a sample title'
    language = 'Ruby'

    expect do
      render partial: '/static/default_landing/partials/github_repo.html.erb', locals: {
      'github_repo_title' => github_repo_title,
      'language' => language,
      }
    end.to raise_error("Missing 'repo_url' key in github_repo landing page block")
  end

  it 'raises an error if github_repo_title key is missing' do
    repo_url = 'https://example.com/org/repo-name'
    language = 'Ruby'

    expect do
      render partial: '/static/default_landing/partials/github_repo.html.erb', locals: {
      'repo_url' => repo_url,
      'language' => language,
      }
    end.to raise_error("Missing 'github_repo_title' key in github_repo landing page block")
  end

  it 'raises an error if language key is missing' do
    repo_url = 'https://example.com/org/repo-name'
    github_repo_title = 'This is a sample title'

    expect do
      render partial: '/static/default_landing/partials/github_repo.html.erb', locals: {
      'repo_url' => repo_url,
      'github_repo_title' => github_repo_title,
      }
    end.to raise_error("Missing 'language' key in github_repo landing page block")
  end
end
