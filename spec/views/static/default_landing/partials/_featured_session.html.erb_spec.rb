require 'rails_helper'

RSpec.describe 'rendering _featured_session landing page partial' do
  it 'renders correctly and alternates between videos' do
    sessions = Session.create(
      [
        { title: 'Session 1', description: 'Session Description', video_url: 'https://a/video/path', author: 'An Author', published: true, created_at: Time.zone.today },
        { title: 'Session 2', description: 'Session Description', video_url: 'https://a/video/path', author: 'An Author', published: true, created_at: Time.zone.today },
      ]
    )
    render partial: '/static/default_landing/partials/featured_session.html.erb', locals: { @sessions => sessions }

    expect(rendered).to include('Session 1').or(include('Session 2'))
  end
end
