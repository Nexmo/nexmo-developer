# -*- coding: utf-8 -*-

module ActiveSupport
  module Inflector
    #stub
    def underscore(string) string; end
    def humanize(string)   string; end
  end
end

require 'spec_helper'

SMALL_WORDS = %w{a an and as at but by en for if in of on or the to v v. via vs vs.}

describe Titleize do
  include Titleize

  describe "phrases" do
    it "should return an array" do
      phrases("a little sentence").should be_an_instance_of(Array)
    end

    it "should split on colons" do
      phrases("this: a subphrase").should == ["this:", "a subphrase"]
    end

    it "should split on semi-colons" do
      phrases("this; that").should == ["this;", "that"]
    end

    it "should split on question marks" do
      phrases("this? that").should == ["this?", "that"]
    end

    it "should split on periods" do
      phrases("this. that.").should == ["this.", "that."]
    end

    it "should split on exclamation marks" do
      phrases("headache! yes").should == ["headache!", "yes"]
    end

    it "should rejoin into the original string" do
      title = "happy: not sad; pushing! laughing? ok."
      phrases(title).join(" ").should == title
    end

    it "should not get confused by small words with punctuation" do
      phrases("this vs. that").should == ["this vs. that"]
      phrases("this vs. that. no").should == ["this vs. that.", "no"]
      phrases("this: that vs. him. no. why?").should ==
        ["this:", "that vs. him.", "no.", "why?"]
      phrases("this vs. that vs. what").should == ["this vs. that vs. what"]
    end

    it "should handle punctuation combined with a small word as the last word" do
      phrases("this. that of").should == ["this.", "that of"]
    end
  end

  describe "titleize" do
    it "should return a string" do
      titleize("this").should be_an_instance_of(String)
    end

    it "should capitalize the first letter of regular words" do
      titleize("cat beats monkey").should == "Cat Beats Monkey"
    end

    it "should not capitalize small words" do
      SMALL_WORDS.each do |word|
        titleize("first #{word} last").should == "First #{word} Last"
      end
    end

    it "should downcase a small word if it is capitalized" do
      SMALL_WORDS.each do |word|
        titleize("first #{word.capitalize} last").should == "First #{word} Last"
      end
    end

    it "should capitalize a small word if it is the first word" do
      SMALL_WORDS.each do |word|
        titleize("#{word} is small").should == "#{word.capitalize} Is Small"
        titleize("after: #{word} ok").should == "After: #{word.capitalize} Ok"
        titleize("after; #{word} ok").should == "After; #{word.capitalize} Ok"
        titleize("after. #{word} ok").should == "After. #{word.capitalize} Ok"
        titleize("after? #{word} ok").should == "After? #{word.capitalize} Ok"
        titleize("after! #{word} ok").should == "After! #{word.capitalize} Ok"
      end
    end

    it "does not capitalize later uses of the first small word" do
      SMALL_WORDS.each do |word|
        titleize("#{word} and #{word} are different").should == "#{word.capitalize} and #{word} Are Different"
      end
    end

    it "should capitalize a small word if it is the last word" do
      SMALL_WORDS.each do |word|
        titleize("small #{word}").should == "Small #{word.capitalize}"
      end
    end

    it "should not screw up acronyms" do
      titleize("the SEC's decision").should == "The SEC's Decision"
    end

    it "should not capitalize words with dots" do 
      titleize("del.icio.us web site").should == "del.icio.us Web Site"
    end

    it "should not think a quotation mark makes a dot word" do
      titleize("'quoted.' yes.").should == "'Quoted.' Yes."
      titleize("ends with 'quotation.'").should == "Ends With 'Quotation.'"
    end

    it "should not capitalize words that have a lowercase first letter" do 
      titleize("iTunes").should == "iTunes"
    end

    it "should not capitalize words that start with a number" do
      titleize("2lmc").should == "2lmc"
    end

    describe "with hyphens" do
      it "should handle hyphenated words" do
        titleize("iPhone la-la land").should == "iPhone La-La Land"
      end

      it "should handle non-breaking hyphens" do
        titleize("non‑breaking hyphen").should == "Non‑Breaking Hyphen"
      end

      it "should not capitalize small words within a hyphenated word" do
        titleize("step-by-step directions").should == "Step-by-Step Directions"
      end
    end

    it "should fix all-caps titles" do
      titleize("IF IT’S ALL CAPS, FIX IT").should == "If It’s All Caps, Fix It"
    end

    # test suite from Perl titlecase
    # http://github.com/ap/titlecase/blob/master/test.pl
    it "should handle edge cases" do
      {
        %{For step-by-step directions email someone@gmail.com} =>
        %{For Step-by-Step Directions Email someone@gmail.com},

        %{2lmc Spool: 'Gruber on OmniFocus and Vapo(u)rware'} =>
        %{2lmc Spool: 'Gruber on OmniFocus and Vapo(u)rware'},

        %{Have you read “The Lottery”?} =>
        %{Have You Read “The Lottery”?},

        %{your hair[cut] looks (nice)} =>
        %{Your Hair[cut] Looks (Nice)},

        %{People probably won't put http://foo.com/bar/ in titles} =>
        %{People Probably Won't Put http://foo.com/bar/ in Titles},

        %{Scott Moritz and TheStreet.com’s million iPhone la‑la land} =>
        %{Scott Moritz and TheStreet.com’s Million iPhone La‑La Land},

        %{BlackBerry vs. iPhone} =>
        %{BlackBerry vs. iPhone},

        %{Notes and observations regarding Apple’s announcements from ‘The Beat Goes On’ special event} =>
        %{Notes and Observations Regarding Apple’s Announcements From ‘The Beat Goes On’ Special Event},

        %{Read markdown_rules.txt to find out how _underscores around words_ will be interpretted} =>
        %{Read markdown_rules.txt to Find Out How _Underscores Around Words_ Will Be Interpretted},

        %{Q&A with Steve Jobs: 'That's what happens in technology'} =>
        %{Q&A With Steve Jobs: 'That's What Happens in Technology'},

        %{What Is AT&T's Problem?} => %{What Is AT&T's Problem?},

        %{Apple Deal With AT&T Falls Through} =>
        %{Apple Deal With AT&T Falls Through},

        %{this v that}   => %{This v That},
        %{this vs that}  => %{This vs That},
        %{this v. that}  => %{This v. That},
        %{this vs. that} => %{This vs. That},

        %{The SEC's Apple Probe: What You Need to Know} =>
          %{The SEC's Apple Probe: What You Need to Know},

        %{'by the Way, small word at the start but within quotes.'} =>
          %{'By the Way, Small Word at the Start but Within Quotes.'},

        %{Small word at end is nothing to be afraid of} =>
          %{Small Word at End Is Nothing to Be Afraid Of},

        %{Starting Sub-Phrase With a Small Word: a Trick, Perhaps?} =>
        %{Starting Sub-Phrase With a Small Word: A Trick, Perhaps?},

        %{Sub-Phrase With a Small Word in Quotes: 'a Trick, Perhaps?'} =>
        %{Sub-Phrase With a Small Word in Quotes: 'A Trick, Perhaps?'},

        %{Sub-Phrase With a Small Word in Quotes: "a Trick, Perhaps?"} =>
        %{Sub-Phrase With a Small Word in Quotes: "A Trick, Perhaps?"},

        %{"Nothing to Be Afraid of?"} => %{"Nothing to Be Afraid Of?"},
        %{"Nothing to Be Afraid Of?"} => %{"Nothing to Be Afraid Of?"},
        %{a thing} => %{A Thing},

        %{Dr. Strangelove (or: how I Learned to Stop Worrying and Love the Bomb)} =>
        %{Dr. Strangelove (Or: How I Learned to Stop Worrying and Love the Bomb)},

        %{  this is trimming} =>
        %{This Is Trimming},

        %{this is trimming  } =>
        %{This Is Trimming},

        %{  this is trimming  } =>
        %{This Is Trimming},

        %{IF IT’S ALL CAPS, FIX IT} =>
        %{If It’s All Caps, Fix It},
      }.each do |before, after|
        titleize(before).should == after
      end
    end
  end

  it "should have titleize as a singleton method" do
    Titleize.singleton_methods.map(&:to_sym).should include(:titleize)
  end
end

describe ActiveSupport::Inflector do
  include ActiveSupport::Inflector

  describe "titleize" do
    before(:each) do
      @title = "active_record and ActiveResource"
    end

    it "should call humanize and underscore like the default in Rails" do
      underscored_title = "active_record and active_resource"
      humanized_title = "Active record and active resource"
      ActiveSupport::Inflector.should_receive(:underscore).with(@title).and_return(underscored_title)
      ActiveSupport::Inflector.should_receive(:humanize).with(underscored_title).and_return(humanized_title)
      titleize(@title).should == "Active Record and Active Resource"
    end

    it "should allow disabling of Inflector#underscore" do
      humanized_title = "Active record and activeresource"
      ActiveSupport::Inflector.should_not_receive(:underscore)
      ActiveSupport::Inflector.should_receive(:humanize).with(@title).and_return(humanized_title)
      titleize(@title, :underscore => false).should == "Active Record and Activeresource"
    end

    it "should allow disabling of Inflector#humanize" do
      underscored_title = "active_record and active_resource"
      ActiveSupport::Inflector.should_not_receive(:humanize)
      ActiveSupport::Inflector.should_receive(:underscore).with(@title).and_return(underscored_title)
      titleize(@title, :humanize => false).should == "Active_record and Active_resource"
    end

    it "should replace Inflector.titleize" do
      Titleize.should_receive(:titleize).with(@title)
      ActiveSupport::Inflector.stub!(:underscore).and_return(@title)
      ActiveSupport::Inflector.stub!(:humanize).and_return(@title)
      ActiveSupport::Inflector.titleize(@title)
    end

    it "should be aliased as titlecase" do
      ActiveSupport::Inflector.singleton_methods.map(&:to_sym).should include(:titlecase)
      ActiveSupport::Inflector.stub!(:titlecase).and_return("title")
      ActiveSupport::Inflector.stub!(:titleize).and_return("title")
      ActiveSupport::Inflector.titlecase("this").should == ActiveSupport::Inflector.titleize("this")
    end
  end
end

describe String do
  it "should have a titleize method" do
    String.instance_methods.map(&:to_sym).should include(:titleize)
  end

  it "should have a titleize! method" do
    String.instance_methods.map(&:to_sym).should include(:titleize!)
  end

  it "should work" do
    "this is a test".titleize.should == "This Is a Test"
  end

  it "should be aliased as #titlecase" do
    String.instance_methods.map(&:to_sym).should include(:titlecase)
    title = "this is a pile of testing text"
    title.titlecase.should == title.titleize
  end

  context 'when using the self modified version of titleize' do
    it 'should work' do
      test_str = 'this is a test'
      test_str.titleize!
      test_str.should == 'This Is a Test'
    end

    it 'should be aliased as #titlecase!' do
      test_str = 'this is a test'
      test_str.titlecase!
      test_str.should == 'This Is a Test'
    end
  end

  context "when ActiveSupport is loaded" do
    it "should act the same as Inflector#titleize" do
      ActiveSupport::Inflector.should_receive(:titleize).with("title", {})
      "title".titleize
    end

    it "should allow disabling of Inflector#underscore" do
      ActiveSupport::Inflector.should_not_receive(:underscore)
      "title".titleize(:underscore => false)
    end

    it "should allow disabling of Inflector#humanize" do
      ActiveSupport::Inflector.should_not_receive(:humanize)
      "title".titleize(:humanize => false)
    end
  end

  context "when ActiveSupport is not loaded" do
    before(:all) do
      Object.send :remove_const, :ActiveSupport
    end

    it "should work" do
      lambda { "foo".titleize }.should_not raise_exception
    end

    it "should call Titleize#titleize" do
      Titleize.should_receive(:titleize).with("title")
      "title".titleize
    end
  end
end
