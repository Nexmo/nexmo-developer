# -*- coding: utf-8 -*-

$LOAD_PATH.push '../lib' unless $LOAD_PATH.include?('../lib')

require 'woothee/dataset'

describe Woothee::DataSet do
  it "contains constants" do
    expect { Woothee::ATTRIBUTE_NAME }.not_to raise_error()
    expect(Woothee::ATTRIBUTE_NAME).to eql(:name)
  end

  it "contains list of categories/attributes" do
    expect { Woothee::ATTRIBUTE_LIST }.not_to raise_error()
    expect { Woothee::CATEGORY_LIST }.not_to raise_error()
    expect(Woothee::ATTRIBUTE_LIST).to eql([
        Woothee::ATTRIBUTE_NAME, Woothee::ATTRIBUTE_CATEGORY, Woothee::ATTRIBUTE_OS,
        Woothee::ATTRIBUTE_VENDOR, Woothee::ATTRIBUTE_VERSION, Woothee::ATTRIBUTE_OS_VERSION,
      ])
    expect(Woothee::CATEGORY_LIST).to eql([
        Woothee::CATEGORY_PC, Woothee::CATEGORY_SMARTPHONE, Woothee::CATEGORY_MOBILEPHONE,
        Woothee::CATEGORY_CRAWLER, Woothee::CATEGORY_APPLIANCE, Woothee::CATEGORY_MISC,
        Woothee::VALUE_UNKNOWN,
      ])
  end

  it "contains dataset" do
    expect(Woothee::DataSet.get('GoogleBot')[:name]).to eql('Googlebot')
  end
end
