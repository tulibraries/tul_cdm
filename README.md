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

Prepare Jetty for Sufia

    bundle exec rails generate hydra:jetty
    bundle exec rake jetty:config
    bundle exec rake jetty:start
    bundle exec rails s -d

Visit the Hydra TUL_CDM site at `http://0.0.0.0:3000`

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
