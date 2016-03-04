## Transaction Load

This application will allow for bulk uploading transactions into Mambu.

## Prerequisites

* Ruby 2.1.5
* PostgreSQL
* Redis 

## Project setup

```git clone git@github.com:netguru/transaction-load.git```

```cd transaction-load```

```bundle install```

```cp config/sec_config.yml.sample config/sec_config.yml```

Please note that api key is required for app to function properly! Place it in sec_config file.

## Database setup

Just copy over the database.yml.sample

```cp config/database.yml.sample  config/database.yml```

then edit the new file and fill in details that match your database.
