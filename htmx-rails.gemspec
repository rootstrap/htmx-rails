# frozen_string_literal: true

require_relative 'lib/htmx/rails/version'

Gem::Specification.new do |spec|
  spec.name          = 'htmx-rails'
  spec.version       = Htmx::Rails::VERSION
  spec.authors       = ['Julian Pasquale']
  spec.email         = ['julian.pasquale@rootstrap.com']
  spec.summary       = 'Ruby gem for use HTMX in Rails applications'
  spec.description   = 'Ruby gem for use HTMX in Rails applications'
  spec.homepage      = 'https://github.com/rootstrap/htmx-rails'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata["homepage_uri"]    = spec.homepage
  spec.metadata["source_code_uri"] = 'https://github.com/rootstrap/htmx-rails'
  spec.metadata["changelog_uri"]   = 'https://github.com/rootstrap/htmx-rails'

  spec.files         = Dir['LICENSE.txt', 'README.md', 'lib/**/*']
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Development dependencies.
  spec.add_development_dependency 'generator_spec'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'reek'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov', '~> 0.17.1'
  spec.add_development_dependency 'psych', '>= 5.1.1.1' # pinned due to https://github.com/ruby/psych/issues/655
end
