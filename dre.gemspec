$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "dre/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "dre"
  s.version     = Dre::VERSION
  s.authors     = ["Anton Ivanopoulos"]
  s.email       = ["a.ivanopoulos@gmail.com"]
  s.homepage    = "http://www.papercloud.com.au"
  s.summary     = "A device registration engine for Rails."
  s.description = "A device registration engine for Rails."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '~> 4.2.1'
  s.add_dependency 'responders', '>= 1.0'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails', '~> 3.0'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'pry'
end
