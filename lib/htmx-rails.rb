# frozen_string_literal: true

# Rails Core
require 'active_support/core_ext/hash'
require 'rails/generators'

# Files
require 'generators/htmx/install_generator'
require 'htmx/rails/version'

module Htmx
  module Rails
    class Error < StandardError; end
  end
end
