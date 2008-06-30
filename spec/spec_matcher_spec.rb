# The specification for my RSpec matcher helper.
#
# Author:: Nolan Eakins <nolan@eakins.net>
# Copyright:: Public domain
# License:: You are free to use and abuse this in anyway.
require 'spec'
require 'spec_matcher_helper'

matcher :test_matcher do
  attr_accessor :expecting, :target
  
  def initialize(*expecting)  #:nodoc:all
    @expecting = expecting
  end
  
  def matches?(target) #:nodoc:all
  end
  
  def failure_message  #:nodoc:all
  end
  
  def negative_failure_message  #:nodoc:all
  end
end

class InheritsFrom
  attr_accessor :expecting
  
  def initialize(expecting)
    @expecting = expecting
  end
  
  def was_inherited?
  end
end

matcher :test_matcher_with_super_class => InheritsFrom do
  def initialize(expecting)  #:nodoc:all
    super(expecting)
  end
  
  def matches?(target) #:nodoc:all
  end
end

matcher :test_matcher_with_super_symbol => :inherits_from do
  def initialize(expecting)  #:nodoc:all
    super(expecting)
  end
  
  def matches?(target) #:nodoc:all
  end
end

describe 'matcher', :shared => true do
  describe 'generates a method using the given name that' do
    it "returns an instance of the generated class" do
      @matcher.should be_kind_of(@klass)
    end
  
    it "passes along its arguments" do
      @matcher.expecting.should == @args
    end
  end
end

describe 'matcher', 'with test_matcher' do
  before(:each) do
    @args = [:a, :b]
    @klass = TestMatcher
    @matcher = test_matcher(*@args)
  end

  it_should_behave_like 'matcher'

  it "responds to all of the methods defined in the block" do
    %W(matches? expecting failure_message negative_failure_message).each do |meth|
      @matcher.should respond_to(meth)
    end
  end
end

describe 'matcher with super', :shared => true do
  before(:each) do
    @args = :arg
    @klass = Object.const_get(@matcher_name.to_s.camelize)
    @method = method(@matcher_name)
    @matcher = @method.call(*@args)
  end

  it_should_behave_like 'matcher'
  
  it "responds to all of the methods defined in the block" do
    %W(matches? expecting).each do |meth|
      @matcher.should respond_to(meth)
    end
  end

  it "subclasses InheritsFrom" do
    @matcher.should be_kind_of(InheritsFrom)
  end
end

describe 'matcher', 'with test_matcher_with_super_class' do
  it_should_behave_like 'matcher with super'
  
  before(:all) do
    @matcher_name = :test_matcher_with_super_class
  end
end

describe 'matcher', 'with test_matcher_with_super_symbol' do
  before(:all) do
    @matcher_name = :test_matcher_with_super_symbol
  end

  it_should_behave_like 'matcher with super'
end
