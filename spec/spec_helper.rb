ENV["RAILS_ENV"] = "test"

$:.unshift File.expand_path('../lib', __FILE__)

require 'rails'
require 'rubygems'
require 'bundler/setup'
require "rails/test_help"
require 'table_for'
require 'support/user'
require 'capybara'