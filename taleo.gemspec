# frozen_string_literal: true

require_relative 'lib/taleo/version'

Gem::Specification.new do |spec|
  spec.name          = 'taleo'
  spec.version       = Taleo::VERSION
  spec.authors       = ['Paul Holden']
  spec.email         = ['paul@codelunker.com']

  spec.summary       = 'A library for using the Taleo REST API'
  spec.description   = 'A library for using the Taleo REST API'
  spec.homepage      = 'https://github.com/paulholden2/taleo'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/paulholden2/taleo'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '~> 1.0'

  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'sinatra', '~> 2.0'
  spec.add_development_dependency 'sinatra-contrib'
  spec.add_development_dependency 'webmock', '~> 3.6'
end
