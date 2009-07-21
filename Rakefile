require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "sinatra-openid"
    gem.summary = %Q{TODO}
    gem.email = "subbarao.pasupuleti@gmail.com"
    gem.homepage = "http://github.com/subbarao/sinatra-openid"
    gem.authors = ["SubbaRao Pasupuleti"]
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end

rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/*_test.rb'
  test.verbose = true
end


task :default => :test

