require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#normalize_summary_title' do
    it 'should return summary if it is not null' do
      expect(helper.normalize_summary_title('Summary Here', 'operationID')).to eql('Summary Here')
    end

    it 'should return operationID if summary is null' do
      expect(helper.normalize_summary_title(nil, 'operationId')).to eql('Operation Id')
    end

    it 'should return SMS in all uppercase' do
      expect(helper.normalize_summary_title(nil, 'sendSms')).to eql('Send SMS')
    end

    it 'should normalize camelCase without exceptions' do
      expect(helper.normalize_summary_title(nil, 'createSecret')).to eql('Create Secret')
    end

    it 'should normalize TitleCase without exceptions' do
      expect(helper.normalize_summary_title(nil, 'CreateSecret')).to eql('Create Secret')
    end

    it 'should normalize snake_case without exceptions' do
      expect(helper.normalize_summary_title(nil, 'create_secret')).to eql('Create Secret')
    end

    it 'should normalize kebab-case without exceptions' do
      expect(helper.normalize_summary_title(nil, 'create-secret')).to eql('Create Secret')
    end

    it 'should normalize camelCase with exceptions' do
      expect(helper.normalize_summary_title(nil, 'createAnSms')).to eql('Create an SMS')
    end

    it 'should normalize camelCase with capitalized exceptions' do
      expect(helper.normalize_summary_title(nil, 'createAnSMS')).to eql('Create an SMS')
    end

    it 'should normalize TitleCase with exceptions' do
      expect(helper.normalize_summary_title(nil, 'CreateAnSMS')).to eql('Create an SMS')
    end

    it 'should normalize snake_case with exceptions' do
      expect(helper.normalize_summary_title(nil, 'create_an_sms')).to eql('Create an SMS')
    end

    it 'should normalize kebab-case with exceptions' do
      expect(helper.normalize_summary_title(nil, 'create-an-sms')).to eql('Create an SMS')
    end
  end
end
