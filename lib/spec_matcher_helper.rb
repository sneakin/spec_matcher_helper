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
# By calling this you will get a class whose name is {name.camelize},
# along with a method called {name}.
#
# If you need or want to inherit from another matcher, you can pass in a hash
# with the first key being the name of the matcher and the value either being
# another matcher's name or a class.
def matcher(name, &code)
  parent = Object
  name, parent = name.to_a.first if name.kind_of? Hash
  parent = Object.const_get(parent.to_s.camelize) if parent.kind_of? Symbol
  
  klass = Class.new(parent)
  Object.const_set(name.to_s.camelize, klass)
  klass.class_eval(&code)

  Object.send :define_method, name.to_s do |*args|
    klass.new(*args)
  end
end
