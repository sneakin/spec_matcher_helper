# An RSpec matcher helper.
#
# Author:: Nolan Eakins <nolan@eakins.net>
# Copyright:: Public domain
# License:: You are free to use and abuse this in anyway.

require 'active_support'

module SemanticGap
  module Spec
    class MatchMaker
      def initialize(name, parent, &code)
        generate_class(name, parent).class_eval(&code)
        generate_method(name)
      end
      
      def generate_class(name, parent)
        klass = Class.new(parent ? parent : Object)

        Object.const_set(name.to_s.camelize, klass)
        @klass = klass
      end
      
      def generate_method(name)
        Object.send :define_method, name.to_s do |*args|
          @klass.new(*args)
        end
      end
    end
  end
end

# Makes defining RSpec matchers a simpler affair. You still have to provide
# the typical set of methods: initialize, matches?, etc. The one thing you
# do not have to do is define a method to instantiate your matcher.
#
# By calling this you will get a class matching the camelized version of {name},
# along with a method called {name}.
#
# If you need or want to inherit from another matcher, you can pass in a hash
# with the first key being {name} and the super as the value.
def matcher(name, &code)
  parent = nil
  name, parent = name.to_a.first if name.kind_of? Hash
  SemanticGap::Spec::MatchMaker.new(name, parent, &code)
end
