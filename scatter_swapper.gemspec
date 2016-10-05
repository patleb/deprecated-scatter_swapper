$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "scatter_swapper/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "scatter_swapper"
  s.version     = ScatterSwapper::VERSION
  s.authors     = ["Patrice Lebel"]
  s.email       = ["patleb@users.noreply.github.com"]
  s.homepage    = "https://github.com/patleb/scatter_swapper"
  s.summary     = "ScatterSwapper"
  s.description = "ScatterSwapper"
  s.license     = "MIT"

  s.files = Dir["{lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 5.0"

  s.add_development_dependency 'bundler', '~> 1.10'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails', '~> 3.5'
end
