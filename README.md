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

### Specs and Elasticsearch

For the spec to pass, an instance of elasticsearch needs to be running on
port 9200 (check config/chewy.yml for current setting)
