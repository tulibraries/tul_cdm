README
======

## Creating the TUL_CDM application

This application has been tested on Ubuntu 14.04, CentOS 6.6, and MacOS X, 10.9 and 10.10.

* Ruby version

  Ruby 2.1.4+

* System dependencies

  - Java Developers Kit 7 or highter
  - An SQL DBMS (This installation uses SQLite)


* Configuration

This application presumes that you have digital assets in CONTENTdm and that you have your API access information handy. This will go into the config/contentdm.yml file. That file contains the following quoted parameters:

  - cdm_server: URL to your CONTENTdm server, for example: "https://server99999.contentdm.oclc.org"
  - cdm_archive: Access URL of your digital library
  - cdm_xpath: "/collections/collection/alias/text()"
  - cdm_user: "CONTENTdm username"
  - cdm_password:  "CONTENTdm password"
  - cdm_download_dir: "/Path/to/hold/downloaded/XML/files"
  - cdm_foxml_dir: "/Path/to/hold/converted/files/to/upload"

* Database initialization

You may seed the database with collections by modifying db/seeds.rb. Add them to TUL_CDM by typing the command `bundle exec rake db:seed` after you have tul_cdm server running.

* How to run the test suite

Run the test suite with the command:

    rspec spec

* Deployment instructions

Clone the source files from the Git repository and install the Ruby gems.

    git clone https://github.com/tulibraries/tul_cdm.git
    cd tul_cdm
    git submodule init
    git submodule update
    bundle install

Make a copy of the example CONTENTdm parameters file:

    cp config/contentdm.yml.example config/contentdm.yml

Edit `config/contentdm.yml`, replacing samples with your ContentDM parameters.

Make a copy of the site specific parameters files

    cp config/tul_cdm.yml.example config/tul_cdm.yml
    cp config/database.yml.example config/database.yml
    cp config/secrets.yml.example config/secrets.yml
    cp config/jetty.yml.example config/jetty.yml
    cp config/fedora.yml.example config/fedora.yml
    cp config/solr.yml.example config/solr.yml

Edit each config file, replacing sample parameters with your site specific values



Migrate the digital collection database

    bundle exec rake db:migrate

Seed the digital collection database with default data (if desired)

    bundle exec rake db:seed

Prepare and run the Jetty server

    bundle exec rails generate hydra:jetty
    bundle exec rake jetty:config
    bundle exec rake jetty:start

Run the TUL_CDM hydra server

    bundle exec rails s -d -b 127.0.0.1

* Use the application

Visit the Hydra TUL_CDM site at `http://localhost:3000`

* Ingest and index assets

To get a list of available collections to ingest:

    bundle exec rake tu_cdm:list

Ingest data. Replace `collection_name` with one of the collections listed from above.

    bundle exec rake tu_cdm:download[collection_name]
    bundle exec rake tu_cdm:convert
    bundle exec rake tu_cdm:ingest

Index objects with one or more of the following tasks:

    bundle exec rake tu_cdm:index:audio
    bundle exec rake tu_cdm:index:clippings
    bundle exec rake tu_cdm:index:ephemera
    bundle exec rake tu_cdm:index:manuscripts
    bundle exec rake tu_cdm:index:pamphlets
    bundle exec rake tu_cdm:index:periodicals
    bundle exec rake tu_cdm:index:photographs
    bundle exec rake tu_cdm:index:posters
    bundle exec rake tu_cdm:index:scholarship
    bundle exec rake tu_cdm:index:sheetmusic
    bundle exec rake tu_cdm:index:transcripts
    bundle exec rake tu_cdm:index:video

* Import digital collection tables.

The digital collection table may be customized by editing `db/digital-collection.csv`.

To update this file, export the `DigitalCollection` database which will overwrite
`db/digital-collection.csv`.

    bundle exec rake tu_cdm:collection:export_csv

This file may be edited in a spreadsheet program and exported to CSV. Rename the exported
file to `digital-collection.csv` and copy it into `db/` directory. Import this file into
the `DigitalCollection` table.

    bundle exec rake tu_cdm:collection:import_csv

* Using a process monitoring framework

To start up both Jetty and Hydra with a process monitoring framework, use the `god` command:

    god -c config/tul_cdm.god    # Start the hydra processes

`god` commands may be applied to both processes with the `tul_cdm` group or on the indiviual processes `jetty` and `hydra`.

    god stop tul_cdm             # Stop all processes in the application (Allow at least 45 seconds for jetty process to stop)
    god start tul_cdm            # Start all processes in the application after they have been stopped
    god stop jetty               # Stop the jetty process (Allow at least 45 seconds for the jetty process to stop)
    god start jetty              # Start a stopped jetty process
    god stop hydra               # Stop the hydra process
    god start hydra              # Start a stopped hydra process
