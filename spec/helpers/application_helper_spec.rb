require 'rails_helper'

RSpec.describe ApplicationHelper, :type => :helper do 
    describe "#normalize_summary_title" do
        it 'should return summary if it is not null' do
            expect(helper.normalize_summary_title("Summary Here", "operationID")).to eql("Summary Here")
        end
    end
end