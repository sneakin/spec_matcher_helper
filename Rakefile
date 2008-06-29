require 'spec/rake/spectask'

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
