require_relative 'lib/cli_trivia/version'

Gem::Specification.new do |spec|
  spec.name          = "cli_trivia"
  spec.version       = CliTrivia::VERSION
  spec.authors       = ["Matt Farncombe"]
  spec.email         = ["matt@farncombe.co"]
  spec.summary       = 'Command Line Trivia Game'
  spec.description   = 'Select multiple choice or boolean questions from a category, or get them randomly.'
  spec.homepage      = 'https://rubygems.org/gems/cli_trivia'
  spec.license       = "MIT"
  #spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/C0mbed/cli_trivia"
  spec.metadata["changelog_uri"] = "https://github.com/C0mbed/cli_trivia"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.1.4"
  spec.add_development_dependency 'httparty', '~> 0.21.0'
  spec.add_development_dependency "pry", ">= 0"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency 'tty-prompt', '~> 0.21.0'
end