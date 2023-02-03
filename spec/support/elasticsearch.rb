RSpec.configure do |config|
  # start an in-memory cluster for Elasticsearch as needed
  config.before :all, elasticsearch: true do
    ItemsIndex.purge!
  end
end
