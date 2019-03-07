require 'rails_helper'

RSpec.describe VideoHelper, type: :helper do
  describe '#video_embed_url' do
    context 'with a youtube video url' do
      let(:video_url) { 'https://www.youtube.com/watch?v=i7EZDYYfFmc' }

      it 'returns a youtube embed url' do
        expect(helper.video_embed_url(video_url)).to eq('https://www.youtube.com/embed/i7EZDYYfFmc?showinfo=0')
      end
    end

    context 'with a vimeo video url' do
      let(:video_url) { 'https://vimeo.com/205296677' }

      it 'returns a vimeo embed url' do
        expect(helper.video_embed_url(video_url)).to eq('https://player.vimeo.com/video/205296677')
      end
    end
  end

  describe '#featured_video' do
    context 'with recent videos' do
      it 'returns two videos' do
        videos = Session.create(
          [
            { title: 'Session 1', description: 'Session Description', video_url: 'https://a/video/path', author: 'An Author', published: true, created_at: Time.zone.today },
            { title: 'Session 2', description: 'Session Description', video_url: 'https://a/video/path', author: 'An Author', published: true, created_at: Time.zone.today },
          ]
        )
        allow(Session).to receive(:where).and_return(videos)

        expect(helper.featured_video.count).to eq(2)
      end
    end
  end
end
