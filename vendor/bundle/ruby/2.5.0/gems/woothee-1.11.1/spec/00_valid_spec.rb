# -*- coding: utf-8 -*-

$LOAD_PATH.push '../lib' unless $LOAD_PATH.include?('../lib')

module Woothee
end

describe Woothee do
  it "should be read from each modules correctly" do
    expect { require 'woothee/dataset' }.not_to raise_error()
    expect { require 'woothee' }.not_to raise_error()
  end

  it "has valid version" do
    expect { require 'woothee/version' }.not_to raise_error()
    expect(Woothee::VERSION).to match(/\A[0-9]+\.[0-9]+\.[0-9]+\z/)
  end
end
