# Check if codeclimate token is set so we don't get notified if it's absent
if ENV['CODECLIMATE_REPO_TOKEN'] 
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.infer_spec_type_from_file_location!
  config.include Devise::TestHelpers, type: :controller
end

VCR.configure do |c|
  c.hook_into :webmock
  c.allow_http_connections_when_no_cassette = true
  c.cassette_library_dir = 'spec/cassettes'
end

def omniauth_twitter_fixture
  JSON.parse(File.read(Rails.root.join("spec/fixtures/omniauth_twitter_response.json")))
end

def user_from_twitter_fixture
  fixture = omniauth_twitter_fixture
  User.from_omniauth(fixture['uid'], fixture)
end

def set_omniauth_twitter(auth_hash=omniauth_twitter_fixture)
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:twitter, omniauth_twitter_fixture)
  @request.env["devise.mapping"] = Devise.mappings[:user]
  @request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
end