module BillingManager
  class Engine < ::Rails::Engine
    isolate_namespace BillingManager

    config.generators do |g|
      g.test_framework(:rspec)
      g.fixture_replacement(:factory_bot)
      g.factory_bot(dir: "spec/factories")
    end

    initializer(:append_migrations) do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end
  end
end
