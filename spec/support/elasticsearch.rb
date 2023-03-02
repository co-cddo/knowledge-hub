RSpec.configure do |config|
  # start an in-memory cluster for Elasticsearch as needed
  config.before :all, elasticsearch: true do
    ItemsIndex.purge!
  end
end

# Saving an item triggers a callout to its source url to update the search index
# This method allows that callout to be mocked.
def mock_callout_to_source_url_on_item_save(remote_content: "")
  allow(ContentScraper).to receive(:call).and_return(remote_content)
end
