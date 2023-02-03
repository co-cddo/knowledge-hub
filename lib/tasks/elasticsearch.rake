namespace :elasticsearch do
  desc "Index items into elasticsearch via import"
  task import: :environment do
    ItemsIndex.import
  end

  desc "Purge items from elasticsearch"
  task purge: :environment do
    ItemsIndex.purge!
  end
end
