namespace :elasticsearch do
  desc "Index items into elasticsearch via import"
  task import: :environment do
    Chewy.strategy(:active_job) do
      ItemsIndex.import
    end
  end

  desc "Purge items from elasticsearch"
  task purge: :environment do
    ItemsIndex.purge!
  end
end
