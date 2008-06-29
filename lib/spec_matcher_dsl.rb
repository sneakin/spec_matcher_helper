# An RSpec matcher helper.
#
# Author:: Nolan Eakins <nolan@eakins.net>
# Copyright:: Public domain
# License:: You are free to use and abuse this in anyway.

require 'active_support'

# Makes defining RSpec matchers a simpler affair. You still have to provide
# the typical set of methods: initialize, matches?, etc. The one thing you
# do not have to do is define a method to instantiate your matcher.
#
# By calling this you will get a class matching the camelized version of {name},
# along with a method called {name}.
#
# If you need or want to inherit from another matcher, you can pass in a hash
# with the first key being {name} and the super as the value.
def defmatcher(name, &code)
  if name.kind_of? Hash
    name, parent = name.to_a.first
    klass = Class.new(parent)
  else
    klass = Class.new
    parent = nil
  end

  Object.const_set(name.to_s.camelize, klass)
  klass.class_eval(&code)

  Object.send :define_method, name.to_s do |*args|
    klass.new(*args)
  end
end
