# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'table_for/version'

Gem::Specification.new do |s|
  s.name = "table_for"
  s.rubyforge_project = "table_for"
  s.version = TableFor::VERSION

  s.authors = ["Nicklas Ramhöj", "Jonas Nicklas"]
  s.email = ["ramhoj@gmail.com", "jnicklas@gmail.com"]
  s.description = "Renders a table for your model collection"

  s.files = Dir.glob("{lib,spec}/**/*") + %w(README.rdoc)
  s.extra_rdoc_files = ["README.rdoc"]

  s.homepage = "http://github.com/ramhoj/table_for"
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.3.6"
  s.summary = "Renders a table for your model collection"

  s.add_development_dependency("rspec", [">= 2.0.0.beta.20"])
  s.add_development_dependency("capybara")

  s.add_dependency("rails", [">= 3.0"])
end
