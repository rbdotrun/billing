source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in billing_manager.gemspec.
gemspec

gem("puma")
gem("pg")
gem("sprockets-rails")

# Start debugger with binding.b [https://github.com/ruby/debug]
# gem "debug", ">= 1.0.0"

group(:development) do
  gem("annotate", "~> 3.1")
end

group(:development, :test) do
  gem("byebug")
end

group(:test) do
  gem("bullet", "~> 7.1")
  gem("capybara")
  gem("cuprite", "~> 0.15")
  gem("database_cleaner", "~> 2.0.1")
  gem("factory_bot_rails", "~> 6.2.0")
  gem("rails-controller-testing")
  gem("rspec-rails", "~> 6.1")
  gem("selenium-webdriver")
  gem("shoulda-matchers", "~> 5.3")
  gem("webmock")
end