require 'rubygems'
require './lib/openstack/compute.rb'
require 'rake/testtask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "openstack-compute"
    gemspec.summary = "OpenStack Compute Ruby API"
    gemspec.description = "API Binding for OpenStack Compute"
    gemspec.email = "dan.prince@rackspace.com"
    gemspec.homepage = "https://launchpad.net/ruby-openstack-compute"
    gemspec.authors = ["Dan Prince"]
    gemspec.add_dependency 'json'
    gemspec.files = Dir.glob('lib/**/*.rb')
    gemspec.files << "README.rdoc"
    gemspec.files << "VERSION"
    gemspec.files << "COPYING"
    gemspec.post_install_message = %Q{
**** PLEASE NOTE **********************************************************************************************

  #{gemspec.name} has been deprecated. Please consider using fog (http://github.com/fog/fog) for all new projects.

***************************************************************************************************************
} if gemspec.respond_to? :post_install_message
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end

  Rake::TestTask.new(:test) do |t|
    t.pattern = 'test/*_test.rb'
    t.verbose = true
  end
  Rake::Task['test'].comment = "Unit"
