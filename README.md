Knowledge Hub
===============

Elasticsearch
-------------

Elasticsearch functionality is provided via the [chewy gem](https://github.com/toptal/chew).

The easiest way to start up an Elasticsearch instance locally is via docker:

```bash
$ docker run --rm --name elasticsearch -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" elasticsearch:7.11.1
```

### Import items into Elasticsearch

If Elasticsearch is running, when an item is created or update, a matching
record in Elasticsearch will be create or update respectively.

If items have been created without Elasticsearch present, they can be
imported via:

```ruby
ItemsIndex.import
```

There is also a Rake task that will do this:

```bash
rake elasticsearch:import
```

A complimentary task will purge the database:

```bash
rake elasticsearch:purge
```

### ActiveJob
Processing of indexes is done via ActiveJob and Sidekiq. This means the processing is done in a background job.

In development, Sidekiq should be running for processing to run successfully. You may also need to install
redis locally. To run Sidekiq locally use the following command:

```bash
sidekiq
```

#### Sidekiq in Production
If you deploy via the web Heroku interface the worker may not start. You can use
the following command to check if the work is running:

```bash
heroku ps --app knowledge-hub
```

The output should be something like this:
```bash
=== web (Basic): bundle exec puma -C config/puma.rb (1)
web.1: up 2023/03/03 18:21:42 +0000 (~ 8m ago)

=== worker (Basic): bundle exec sidekiq (1)
worker.1: up 2023/03/03 18:26:25 +0000 (~ 3m ago)
```
If the worker lines are missing the worker is not running.

To start the worker use:
```bash
heroku ps:scale worker+1 --app knowledge-hub
```

### Specs and Elasticsearch

For the spec to pass, an instance of elasticsearch needs to be running on
port 9200 (check config/chewy.yml for current setting)
