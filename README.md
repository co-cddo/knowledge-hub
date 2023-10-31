Knowledge Hub
===============
This application is built to provide information on the location of knowledge items.
A knowledge item is typically a web page contain information about various subjects.

The hub is built to be generic with each item having a description and a location URL.
The location URL being the place where the knowledge exists.

The items could be arranged in a heirachy so that similar items could be grouped within
a parent item, or an item could have a series of subitems as child items.
It is envisaged that the top level parent items could be organisational units such as
government departments.

A search tool is included. This contained the data scraped from the location URL. So
a search action gathers not only the information in the item description, but
also data from the remote resource itself.

Project Status
--------------
This project has been archive. The application is currently at the prototype stage
and should be considered as an example of how a knowledge hub could be constructed.

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
