require 'spec_helper'

describe GreenhouseIo::Error do

  describe "#inspect" do

    context "when http error code is present" do
      it "creates an error with the code" do
        http_error = GreenhouseIo::Error.new(nil, 404)
        expect(http_error.code).to eq(404)
      end
    end

    context "when its an internal gem error" do
      it "creates an error with a message" do
        gem_error = GreenhouseIo::Error.new("organization can't be blank", nil)
        expect(gem_error.message).to eq("organization can't be blank")
      end
    end

  end

end
