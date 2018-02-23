# Statuspage.io webhook notifications for Slack

A tiny Sinatra app that receives webhooks from Statuspage.io subscriptions and re-posts them as Slack formatted hooks.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

Based on [docker-to-slack](https://github.com/tdmalone/docker-to-slack), which itself is a fork of a fork. Thanks to both [Thomas Sunde Nielsen](https://github.com/thomassnielsen) and [Neon Adventures](https://github.com/neonadventures).

## Setup

1. Generate an incoming webhook in the Slack integration settings e.g. `https://hooks.slack.com/services/<your-service-tag…>`
2. Create a new webhook subscription on a Statuspage.io status page pointing to this url. e.g. `https://<your-heroku-subdomain>.herokuapp.com/services/<your-service-tag…>`

Not all Statuspage.io status pages have webhooks enabled as a subscription option. If the one you're looking for doesn't, tweet the company and ask them to enable the option in their Statuspage.io dashboard!

## Development

To set up for local development and testing (assuming you already have [Ruby](https://www.ruby-lang.org/en/) installed):

    git clone https://github.com/tdmalone/statuspage-to-slack.git
    cd statuspage-to-slack
    sudo gem install bundler
    bundle install

To start the server:

    rackup

Then visit http://localhost:9292/test, and confirm that it shoots 'test' back to you :).

To simulate a live notification straight into your Slack webhook:

    curl http://localhost:9292/services/<your-slack-service-tag…> --data-binary "@tests/fixtures/incident.json"

You can see what a real notification payload would look like by opening up [`incident.json`](tests/fixtures/incident.json). For more details, see [Statuspage.io's webhooks documentation](http://help.statuspage.io/knowledge_base/topics/webhook-notifications).
