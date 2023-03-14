# frozen_string_literal: true

Seeder = Dibber::Seeder

ItemsIndex.purge!

Seeder.seed Location
Seeder.seed Item

Chewy.strategy(:active_job) do
  ItemsIndex.import
end

puts Seeder.report
