require_relative "lib/biovision/taxonomy/version"

Gem::Specification.new do |spec|
  spec.name        = "biovision-taxonomy"
  spec.version     = Biovision::Taxonomy::VERSION
  spec.authors     = ["Maxim Khan-Magomedov"]
  spec.email       = ["maxim.km@gmail.com"]
  spec.homepage    = "https://github.com/Biovision/biovision-taxonomy"
  spec.summary     = "Taxonomy for biovision."
  spec.description = "Taxonomy component for biovision-based sites."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Biovision/biovision-taxonomy"
  spec.metadata["changelog_uri"] = "https://github.com/Biovision/biovision-taxonomy"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.1", ">= 6.1.3.1"
  spec.add_dependency 'rails-i18n', '~> 6.0'

  spec.add_dependency 'biovision'

  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'factory_bot_rails'
end
