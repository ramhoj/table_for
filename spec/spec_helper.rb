ENV["RAILS_ENV"] = "test"

$:.unshift File.expand_path('../lib', __FILE__)

require 'rails'
require 'rubygems'
require 'bundler/setup'
require "rails/test_help"

Dir["#{File.expand_path(File.dirname(__FILE__))}/../lib/table_for/*.rb"].each {|f| require(f) unless f =~ /version\.rb$/ }
Dir["#{File.expand_path(File.dirname(__FILE__))}/support/*.rb"].each {|f| require(f) }