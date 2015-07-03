# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shadefinale_minesweeper/version'

Gem::Specification.new do |spec|
  spec.name          = "shadefinale_minesweeper"
  spec.version       = ShadefinaleMinesweeper::VERSION
  spec.authors       = ["Donald Kelsey"]
  spec.email         = ["dmkelseyii@gmail.com"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  end

  spec.summary       = %q{A simple game of minesweeper}
  # spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "www.donaldkelsey.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
end
