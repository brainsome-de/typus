# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'typus/version'

files = Dir['**/*'].keep_if{|file| File.file?(file)}
test_files = Dir['test/**/*'].keep_if{|file| File.file?(file)}
ignores = Dir['doc/**/*'].keep_if{|file| File.file?(file)} + %w(.travis.yml .gitignore)

Gem::Specification.new do |spec|
  spec.name          = "brainsome_typus"
  spec.version       = Typus::VERSION::STRING
  spec.authors       = ["Francesc Esplugas", "Brainsome-Developers"]
  spec.email         = ["support@typuscmf.com", nil]
  spec.description   = "Ruby on Rails Admin Panel (Engine) to allow trusted users edit structured content."
  spec.summary       = "Effortless backend interface for Ruby on Rails applications. (Admin scaffold generator)"
  spec.homepage      = "https://github.com/brainsome-de/typus"
  spec.license       = "MIT"

  spec.platform = Gem::Platform::RUBY

  spec.files         = files - test_files - ignores
  spec.test_files    = []
  spec.require_paths = ["lib"]

  spec.required_ruby_version     = '>= 1.9.3'
  spec.required_rubygems_version = '>= 1.8.11'

  spec.add_dependency "bcrypt-ruby", "~> 3.1.2"
  spec.add_dependency "jquery-rails"
  spec.add_dependency "rails", "~> 4"
end
