== README

Here are the basic steps to get TUL_Cdm up and running.

    git clone git@github.com:tulibraries/tul_cdm.git
    git submodule init
    git submodule update
    bundle install
    cp config/contentdm.yml.example config/contentdm.yml

Edit `config/contentdm.yml`. Replace samples with your ContentDM parameters

Generate the TUL_CDM application. Answer `n` to all prompts

    bundle exec rails generate hydra:install

Restore files the hydra install modified

    git checkout -- .

Prepare Jetty

    bundle exec rails generate hydra:jetty
    bundle exec rake jetty:config
    bundle exec rake jetty:start
    bundle exec rails s -d

Visit the Hydra TUL_CDM site at `http://0.0.0.0:3000`

To get a list of available collecitons to ingest:

    bundle exec rake tu_cdm:list

Ingest data. Replace `collection_name` with one of the collections listed from above.

    bundle exec rake tu_cdm:download[collection_name]
    bundle exec rake tu_cdm:ingest
    bundle exec rake tu_cdm:convert

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

* Ruby version

We use Ruby 2.1.4+

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.
