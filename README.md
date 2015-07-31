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

Clone the source files from the Git repository and install the ruby gems.

    git clone https://github.com/tulibraries/tul_cdm.git
    cd tul_cdm
    git submodule init
    git submodule update
    bundle install

Confiure the CONTENTdm parameters:

    cp config/contentdm.yml.example config/contentdm.yml
    # Edit and replace samples with your ContentDM parameters.

Configure site specific parameters:

    cp config/tul_cdm.yml.example config/tul_cdm.yml
    # Edit and replace sample parameters with your site specific values

Generate the TUL_CDM application. Answer `n` to all prompts

    bundle exec rails generate hydra:install

Restore files the hydra install modified

    git checkout -- .

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
