module Biovision
  module Taxonomy
    require 'biovision'

    class Engine < ::Rails::Engine
      config.generators do |g|
        g.test_framework :rspec
        g.fixture_replacement :factory_bot, dir: 'spec/factories'
      end

      initializer 'sample_engine.factories', after: 'factory_bot.set_factory_paths' do
        FactoryBot.definition_file_paths << File.expand_path('../../../spec/factories', __FILE__) if defined?(FactoryBot)
      end
    end
  end
end
