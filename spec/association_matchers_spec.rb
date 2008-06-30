require 'active_record'
require 'spec'
require 'spec_matcher_helper'
require 'association_matchers'

class Record < ActiveRecord::Base
  belongs_to :parent, :class_name => Record
end

describe :belongs_to do
  it "checks a belongs_to association" do
    Record.stub!(:connect)
    # TODO: needs a db connection
    Record.should belong_to(:parent)
  end
end
