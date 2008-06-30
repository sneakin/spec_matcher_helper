require 'spec/rake/spectask'
require 'rubygems'
require 'rake/gempackagetask'

desc "Run the specs"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.ruby_opts = [ "-Ilib", "-rrubygems" ]
  t.spec_files = FileList['spec/**/*_spec.rb']
end

directory 'doc'

namespace :spec do
  desc "Run the specs with RCov"
  Spec::Rake::SpecTask.new(:rcov) do |t|
    t.ruby_opts = [ "-Ilib", "-rrubygems" ]
    t.spec_files = FileList['spec/**/*_spec.rb']
    t.rcov = true
    t.rcov_opts = [ "-ilib/*.rb" ]
  end

  desc "Run the specs with HTML output"
  Spec::Rake::SpecTask.new(:html => ['doc']) do |t|
    t.ruby_opts = [ "-Ilib", "-rrubygems" ]
    t.spec_opts = [ "--format", "html:doc/spec.html"]
    t.spec_files = FileList['spec/**/*_spec.rb']
    t.rcov = true
    t.rcov_opts = [ "-ilib/*.rb" ]
  end
end

gem = Gem::Specification.new do |s|
  s.name       = "spec_matcher_helper"
  s.version    = "0.0.1"
  s.author     = "Nolan Eakins"
  s.email      = "nolan at eakins dot net"
  s.homepage   = "http://github.com/sneakin/spec_matcher_helper/"
  s.platform   = Gem::Platform::RUBY
  s.summary    = "A small helper to create RSpec matchers and calling methods"
  s.files      = FileList["{lib,spec}/**/*"]
  s.require_path      = "lib"
  s.autorequire       = "spec_matcher_helper"
  s.test_file         = "spec/spec_matcher_spec.rb"
  s.has_rdoc          = true
  s.extra_rdoc_files  = ['README']
end

Rake::GemPackageTask.new(gem) do |s|
  s.need_zip = true
  s.need_tar = true
end
