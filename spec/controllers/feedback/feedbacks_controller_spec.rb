require 'rails_helper'

RSpec.describe Feedback::FeedbacksController, type: :controller do
  describe 'POST create' do
    it 'creates a author and feedback' do
      post :create, xhr: true, params: {
        feedback_feedback: {
          sentiment: 'positive',
          comment: 'Some feedback text',
          source: 'https://developer.nexmo.com/some/path',
        },
      }

      expect(User.count).to eq(0)
      expect(Feedback::Author.count).to eq(1)
      expect(Feedback::Feedback.count).to eq(1)
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(response.cookies['feedback_author_id']).to eq(Feedback::Author.last.id)
    end

    context 'when an email is provided' do
      before do
        @email = Faker::Internet.safe_email
      end

      it 'creates a author with an email' do
        post :create, xhr: true, params: {
          feedback_feedback: {
            sentiment: 'positive',
            comment: 'Some feedback text',
            source: 'https://developer.nexmo.com/some/path',
            email: @email,
          },
        }

        expect(User.count).to eq(0)
        expect(Feedback::Author.count).to eq(1)
        expect(Feedback::Author.last.email).to eq(@email)
      end

      context 'and the author exists already' do
        before do
          @author = FactoryBot.create(:feedback_author)
        end

        it 'reuses the author' do
          post :create, xhr: true, params: {
            feedback_feedback: {
              sentiment: 'positive',
              comment: 'Some feedback text',
              source: 'https://developer.nexmo.com/some/path',
              email: @author.email,
            },
          }

          expect(Feedback::Feedback.last.owner).to eq(@author)
        end
      end
    end

    context 'when an author cookie is provided' do
      before do
        @author = FactoryBot.create(:feedback_author)
        request.cookies['feedback_author_id'] = @author.id
      end

      it 'reuses the author' do
        post :create, xhr: true, params: {
          feedback_feedback: {
            sentiment: 'positive',
            comment: 'Some feedback text',
            source: 'https://developer.nexmo.com/some/path',
          },
        }

        expect(Feedback::Feedback.last.owner).to eq(@author)
      end

      context 'but the email does not match' do
        it 'creates a new author' do
          post :create, xhr: true, params: {
            feedback_feedback: {
              sentiment: 'positive',
              comment: 'Some feedback text',
              source: 'https://developer.nexmo.com/some/path',
              email: Faker::Internet.safe_email,
            },
          }

          expect(Feedback::Feedback.last.owner).to_not eq(@author)
          expect(Feedback::Author.count).to eq(2)
        end
      end
    end

    context 'when a user is logged in' do
      before do
        @email = Faker::Internet.safe_email
        @user = FactoryBot.create(:user, email: @email)
        sign_in(@user)
      end

      it 'reuses the user' do
        post :create, xhr: true, params: {
          feedback_feedback: {
            sentiment: 'positive',
            comment: 'Some feedback text',
            source: 'https://developer.nexmo.com/some/path',
          },
        }

        expect(User.count).to eq(1)
        expect(Feedback::Author.count).to eq(0)
        expect(Feedback::Feedback.last.owner).to eq(@user)
      end

      context 'and an email is provided' do
        it 'ignores the email' do
          post :create, xhr: true, params: {
            feedback_feedback: {
              sentiment: 'positive',
              comment: 'Some feedback text',
              source: 'https://developer.nexmo.com/some/path',
              email: Faker::Internet.safe_email,
            },
          }

          expect(@user.email).to eq(@email)
        end
      end
    end

    context 'when a feedback already exists' do
      before do
        @feedback = FactoryBot.create(:feedback_feedback, sentiment: 'positive')
      end

      it 'can be updated' do
        post :create, xhr: true, params: {
          feedback_feedback: {
            id: @feedback.id,
            sentiment: 'negative',
          },
        }

        expect(Feedback::Feedback.last.id).to eq(@feedback.id)
        expect(Feedback::Feedback.last.sentiment).to eq('negative')
      end
    end
  end
end
