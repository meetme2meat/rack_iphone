# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "rack_iphone"
  gem.homepage = "http://github.com/meetme2meat/rack_iphone"
  gem.license = "MIT"
  gem.summary = %Q{Rack Iphone is  use for auto login from iphone home screen shortcut}
  gem.description = %Q{Rack Iphone is use for auto login for web app from iphone when activated from home screen shortcut. The Gem is Inspired by work of Jim Hoskins gem rack_iphone_web_app}
  gem.email = "meetme2meat@gmail.com"
  gem.authors = ["Viren Negi"]
  gem.files = Dir.glob('lib/**/*.rb')
  gem.files.include "rack_iphone.rb"
  gem.add_runtime_dependency 'rack'
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "gems/*"'
end

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "rack_iphone #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
