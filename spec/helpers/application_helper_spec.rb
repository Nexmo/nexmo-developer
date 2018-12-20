require 'rails_helper'

RSpec.describe ApplicationHelper, :type => :helper do 
    describe "#normalize_summary_title" do
        it 'should return summary if it is not null' do
            expect(helper.normalize_summary_title("Summary Here", "operationID")).to eql("Summary Here")
        end
        it 'should return operationID if summary is null' do
            expect(helper.normalize_summary_title(nil, "operationId")).to eql("Operation Id")
        end
        it 'should return SMS in all uppercase' do
            expect(helper.normalize_summary_title(nil, "sendSms")).to eql("Send SMS")
        end
    end
end