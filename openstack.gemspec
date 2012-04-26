# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "openstack"
  s.version = "1.1.9"
  s.has_rdoc = true
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dan Prince", "Marios Andreou"]
  s.date = "2012-04-26"
  s.description = "API Binding for OpenStack"
  s.email = ["dprince@redhat.com", "marios@redhat.com"]
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "COPYING",
    "README.rdoc",
    "VERSION",
    "lib/openstack.rb",
    "lib/openstack/compute/address.rb",
    "lib/openstack/compute/connection.rb",
    "lib/openstack/compute/flavor.rb",
    "lib/openstack/compute/image.rb",
    "lib/openstack/compute/metadata.rb",
    "lib/openstack/compute/personalities.rb",
    "lib/openstack/compute/server.rb",
    "lib/openstack/connection.rb",
    "lib/openstack/swift/connection.rb",
    "lib/openstack/swift/container.rb",
    "lib/openstack/swift/storage_object.rb",
    "lib/openstack/swift/version.rb"
  ]
  s.homepage = "https://launchpad.net/ruby-openstack-compute"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.7.2"
  s.summary = "OpenStack Ruby API"

  if s.respond_to? :specification_version then
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

