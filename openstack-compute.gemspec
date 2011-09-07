# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{openstack-compute}
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dan Prince"]
  s.date = %q{2011-09-07}
  s.description = %q{API Binding for OpenStack Compute}
  s.email = %q{dan.prince@rackspace.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "COPYING",
     "README.rdoc",
     "VERSION",
     "lib/openstack/compute.rb",
     "lib/openstack/compute/authentication.rb",
     "lib/openstack/compute/connection.rb",
     "lib/openstack/compute/exception.rb",
     "lib/openstack/compute/flavor.rb",
     "lib/openstack/compute/image.rb",
     "lib/openstack/compute/metadata.rb",
     "lib/openstack/compute/server.rb"
  ]
  s.homepage = %q{https://launchpad.net/ruby-openstack-compute}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{OpenStack Compute Ruby API}
  s.test_files = [
    "test/authentication_test.rb",
     "test/exception_test.rb",
     "test/test_helper.rb",
     "test/metadata_test.rb",
     "test/connection_test.rb",
     "test/servers_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json>, [">= 0"])
    else
      s.add_dependency(%q<json>, [">= 0"])
    end
  else
    s.add_dependency(%q<json>, [">= 0"])
  end
end

