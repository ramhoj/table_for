# frozen_string_literal: true

ENV["RAILS_ENV"] = "test"

$LOAD_PATH.unshift File.expand_path("lib", __dir__)

require "rails"
require "rubygems"
require "bundler/setup"
require "rails/test_help"
require "table_for"
require "support/user"
require "capybara"
